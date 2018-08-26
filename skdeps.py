import argparse
import os
import subprocess
import shutil
import platform
import sys

ninja_path = ""
gn_path = ""
skia_path = ""
use_clang = False
last_build_ok = False
build_debug = False
buildx64 = False
enable_log = True


def logging(string):
    print(string)


def convertToAbsolutePath(path):
    if path is None or not path or not os.path.exists(path):
        return ""
    if not os.path.isabs(path):
        return os.path.abspath(path)
    return path


def execBuild(cmd, use_shell, cw):
    try:
        p = subprocess.Popen(cmd, shell=use_shell, cwd=cw)
        p.communicate()
        retcode = p.wait()
        if retcode == 0:
            return True
        if retcode < 0:
            if enable_log:
                logging("Child was terminated by signal: " + -retcode)
    except BaseException:
        if enable_log:
            logging("Execution failed: " + cmd + " from cwd: " + cw)
    return False


def buildGN(fromPath):
    global skia_path, buildx64, use_clang, last_build_ok
    builddir = fromPath + "/out"
    if os.path.exists(builddir):
        try:
            shutil.rmtree(builddir)
        except OSError as e:
            None
    cmd = ""
    if platform.system() != "Windows" and use_clang:
        cmd += "CC=clang CXX=clang++ CXXFLAGS=\"-stdlib=libc++ -std=c++14\" python " + \
            fromPath + "/build/gen.py "
    else:
        cmd +="python "+ fromPath+"/build/gen.py " 
    if platform.system() == "Windows":
        cmd += "--platform=msvc"
        if buildx64:
            cmd += " --is-x64win"
    elif platform.system() == "linux":
        cmd += "--no-sysroot --platform=linux"

    last_build_ok = execBuild(cmd, platform.system() != "Windows", fromPath)
    if not last_build_ok:
        if enable_log:
            logging("bootstrap gn failed")
        return last_build_ok
    cmd1 = skia_path + "/"
    if platform.system() == "Windows":
        cmd1 += "/ninja.exe"
    else:
        cmd1 += "/ninja"
    last_build_ok = execBuild(cmd1, platform.system() != "Windows", builddir)
    if last_build_ok:
        try:
            if platform.system() == "Windows":
                shutil.copy(fromPath + "/out/gn.exe", skia_path)
                shutil.copy(fromPath + "/out/gn.exe", skia_path + "/bin")
            else:
                shutil.copy(fromPath + "/out/gn", skia_path)
                shutil.copy(fromPath + "/out/gn", skia_path + "/bin")
        except BaseException:
            if enable_log:
                logging("buildGN copy failed")
                last_build_ok = False
    else:
        if enable_log:
            logging("bootstrap gn build failed")
    return last_build_ok


def buildSkia(fromPath):
    global skia_path, buildx64, build_debug, use_clang, last_build_ok
    builddir = fromPath + "/out"
    if os.path.exists(builddir):
        try:
            shutil.rmtree(builddir)
        except OSError as e:
            None

    try:
        os.mkdir(builddir)
    except BaseException:
        if enable_log:
            logging("prepare mkdir out skia build failed")
        return False

    gn_arg = ""
    if buildx64:
        gn_arg += "target_cpu = \"x64\" \n"
    else:
        gn_arg += "target_cpu = \"x86\" \n"
    if build_debug:
        gn_arg += "is_debug = true \n"
    else:
        gn_arg += "is_debug= false \n"
    if platform.system() == "Windows":
        if build_debug:
            gn_arg += '''
            \nextra_cflags_c = ["/MDd","-D_SCL_SECURE_NO_WARNINGS"]
            \nextra_cflags_cc = ["/MDd","-D_SCL_SECURE_NO_WARNINGS"]
            '''
        else:
            gn_arg += '''
            \nextra_cflags_c = ["/MD","-D_SCL_SECURE_NO_WARNINGS"]
            \nextra_cflags_cc = ["/MD","-D_SCL_SECURE_NO_WARNINGS"]
            '''
    elif platform.system() == "Linux" or platform.system() == "FreeBSD":
        gn_arg += "extra_cflags_c = [\"-fPIC\"] \n"
        if use_clang:
            gn_arg += "extra_cflags_cc = [\"-stdlib=libc++\",\"-fPIC\",\"-std=c++14\"] \n"
    if enable_log:
        logging("generated args.gn contents: \n" + gn_arg)
    try:
        f = open(builddir + "/args.gn", "w")
        f.write(gn_arg)
        f.close()
    except BaseException:
        if enable_log:
            logging("failed to write " + builddir + "/args.gn, giving up")
        return False

    cmd1 = fromPath
    if platform.system() == "Windows":
        cmd1 += "/gn.exe"
    else:
        cmd1 += "/gn"
    cmd1 += " gen out"
    last_build_ok = execBuild(cmd1, platform.system() != "Windows", fromPath)
    cmd2 = fromPath
    if platform.system() == "Windows":
        cmd2 += "/ninja.exe skia"
    else:
        cmd2 += "/ninja skia"
    if last_build_ok:
        last_build_ok = execBuild(
            cmd2,
            platform.system() != "Windows",
            fromPath + "/out")
        if not last_build_ok and enable_log:
            logging("build skia failed")
    else:
        if enable_log:
            logging("gn gen step of skia failed")
    return last_build_ok


def buildNinja(fromPath):
    global skia_path, enable_log, use_clang, last_build_ok
    builddir = fromPath + "/build"
    if os.path.exists(builddir):
        try:
            shutil.rmtree(builddir)
            if platform.system() == "Windows":
                os.remove(fromPath + "/ninja.exe")
                os.remove(fromPath + "/ninja.bootstrap.exe")
            else:
                os.remove(fromPath + "/ninja.bootstrap")
                os.remove(fromPath + "/ninja")
        except OSError as e:
            None

    cmd = "python " + fromPath + "/configure.py --bootstrap"

    if platform.system() == "Windows":
        cmd += " --platform=msvc"
    if platform.system() == "linux":
        if use_clang:
            cmd += " --platform=linux CXXFLAGS=\"-std=c++11 -stdlib=libc++\" "
        else:
            cmd += " --platform=linux CXXFLAGS=\"-std=gnu++11\" LDFLAGS=\"-lstdc++\" "
    if platform.system() == "freebsd":
        cmd += " --platform=freebsd CXXFLAGS=\"-std=c++11 -stdlib=libc++\""
    if enable_log:
        logging("generated cmd: " + cmd)
    last_build_ok = execBuild(cmd, platform.system() != "Windows", fromPath)
    if last_build_ok:
        try:
            if platform.system() == "Windows":
                shutil.copy(fromPath + "/ninja.exe", skia_path)
            else:
                shutil.copy(fromPath + "/ninja", skia_path)
        except OSError as e:
            if enable_log:
                logging("copy ninja bin app failed")
            last_build_ok = False
    else:
        if enable_log:
            logging("build ninja tool failed..")
    return last_build_ok


def isValidSkdepsPath(path):
    global ninja_path, gn_path, skia_path, enable_log
    basepath = path
    if path == ".":
        basepath = os.getcwd()
    ninja_path = basepath + "/ninja"
    gn_path = basepath + "/gn"
    skia_path = basepath + "/skia"
    if not os.path.exists(ninja_path) or not os.path.exists(
            gn_path) or not os.path.exists(skia_path):
        return False
    ninja_conf = ninja_path + "/configure.py"
    if not os.path.isfile(ninja_conf):
        return False
    gn_conf = gn_path + "/build/gen.py"
    if not os.path.isfile(gn_conf):
        return False

    return True


def buildTool():
    global ninja_path, gn_path, last_build_ok
    last_build_ok = buildNinja(ninja_path)
    if last_build_ok:
        last_build_ok = buildGN(gn_path)
    return last_build_ok


parser = argparse.ArgumentParser()
parser.add_argument("--dir", default="",help="skdeps root directory")
parser.add_argument(
    "--build_debug",
    help="build skia debug mode, instead of release",
    action="store_true")
parser.add_argument(
    "--disable-logging",
    help="disable logging",
    action="store_true")
parser.add_argument(
    "--rebuildtool",
    help="rebuild the tool if they are found in skia folder",
    action="store_true")
parser.add_argument(
    "--is_clang",
    help="use clang libc++ on linux instead of g++",
    action="store_true")
parser.add_argument(
    "--buildx64",
    help="assume to build x64 bit lib instead of 32 bit",
    action="store_true")
args = parser.parse_args()
if platform.system() != "Windows":
    use_clang = args.is_clang

if sys.version_info.major ==3:
    logging("need python version 2.7 to work and complete skia build :(")
    sys.exit(-3)
rebuild_tool = args.rebuildtool
enable_log = not args.disable_logging
path = convertToAbsolutePath(args.dir)
build_debug = args.build_debug
buildx64 = args.buildx64
if os.path.exists(path) and isValidSkdepsPath(path):
    if enable_log:
        logging("use path " + path)
    if not rebuild_tool:
        if platform.system() == "Windows":
            if os.path.isfile(skia_path +
                              "/ninja.exe") and os.path.isfile(skia_path +
                                                               "/bin/gn.exe"):
                rebuild_tool = False
            else:
                rebuild_tool = True
        else:
            if os.path.isfile(skia_path +
                              "/ninja") and os.path.isfile(skia_path +
                                                           "/bin/gn"):
                rebuild_tool = False
            else:
                rebuild_tool = True

    if rebuild_tool:
        buildTool()
    ret = False
    if last_build_ok or not rebuild_tool:
        ret = buildSkia(skia_path)
    if not ret:
        if enable_log:
            logging("build failed ")
        sys.exit(-2)
else:
    if enable_log:
        logging("possible invalid invocation")
    parser.print_help()
    sys.exit(-1)
