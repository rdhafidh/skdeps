// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: SkinnedVertShader.vsh ********

// File data
static const char _SkinnedVertShader_vsh[] = 
	"/*\n"
	"\tIf the current vertex is affected by bones then the vertex position and\n"
	"\tnormal will be transformed by the bone matrices. Each vertex wil have up \n"
	"\tto 4 bone indices (inBoneIndex) and bone weights (inBoneWeights).\n"
	"\t\n"
	"\tThe indices are used to index into the array of bone matrices \n"
	"\t(BoneMatrixArray) to get the required bone matrix for transformation. The \n"
	"\tamount of influence a particular bone has on a vertex is determined by the\n"
	"\tweights which should always total 1. So if a vertex is affected by 2 bones \n"
	"\tthe vertex position in world space is given by the following equation:\n"
	"\n"
	"\tposition = (BoneMatrixArray[Index0] * inVertex) * Weight0 + \n"
	"\t           (BoneMatrixArray[Index1] * inVertex) * Weight1\n"
	"\n"
	"\tThe same proceedure is applied to the normals but the translation part of \n"
	"\tthe transformation is ignored.\n"
	"\n"
	"\tAfter this the position is multiplied by the view and projection matrices \n"
	"\tonly as the bone matrices already contain the model transform for this \n"
	"\tparticular mesh. The two-step transformation is required because lighting \n"
	"\twill not work properly in clip space.\n"
	"*/\n"
	"\n"
	"attribute highp   vec3 inVertex;\n"
	"attribute mediump vec3 inNormal;\n"
	"attribute mediump vec3 inTangent;\n"
	"attribute mediump vec3 inBiNormal;\n"
	"attribute mediump vec2 inTexCoord;\n"
	"attribute mediump vec4 inBoneIndex;\n"
	"attribute mediump vec4 inBoneWeights;\n"
	"\n"
	"uniform highp   mat4 ViewProjMatrix;\n"
	"uniform mediump vec3 LightPos;\n"
	"uniform mediump\tint\t BoneCount;\n"
	"uniform highp   mat4 BoneMatrixArray[8];\n"
	"uniform highp   mat3 BoneMatrixArrayIT[8];\n"
	"uniform bool\tbUseDot3;\n"
	"\n"
	"varying mediump vec3 Light;\n"
	"varying mediump vec2 TexCoord;\n"
	"\n"
	"void main()\n"
	"{\n"
	"\tif(BoneCount > 0)\n"
	"\t{\n"
	"\t\t// On PowerVR SGX it is possible to index the components of a vector\n"
	"\t\t// with the [] operator. However this can cause trouble with PC\n"
	"\t\t// emulation on some hardware so we \"rotate\" the vectors instead.\n"
	"\t\tmediump ivec4 boneIndex = ivec4(inBoneIndex);\n"
	"\t\tmediump vec4 boneWeights = inBoneWeights;\n"
	"\t\n"
	"\t\thighp mat4 boneMatrix = BoneMatrixArray[boneIndex.x];\n"
	"\t\tmediump mat3 normalMatrix = BoneMatrixArrayIT[boneIndex.x];\n"
	"\t\n"
	"\t\thighp vec4 position = boneMatrix * vec4(inVertex, 1.0) * boneWeights.x;\n"
	"\t\tmediump vec3 worldNormal = normalMatrix * inNormal * boneWeights.x;\n"
	"\t\t\n"
	"\t\tmediump vec3 worldTangent;\n"
	"\t\tmediump vec3 worldBiNormal;\n"
	"\t\t\n"
	"\t\tif(bUseDot3)\n"
	"\t\t{\n"
	"\t\t\tworldTangent = normalMatrix * inTangent * boneWeights.x;\n"
	"\t\t\tworldBiNormal = normalMatrix * inBiNormal * boneWeights.x;\n"
	"\t\t}\n"
	"\t\n"
	"\t\tfor (lowp int i = 1; i < 3; ++i)\n"
	"\t\t{\n"
	"\t\t\tif(i < BoneCount)\n"
	"\t\t\t{\n"
	"\t\t\t\t// \"rotate\" the vector components\n"
	"\t\t\t\tboneIndex = boneIndex.yzwx;\n"
	"\t\t\t\tboneWeights = boneWeights.yzwx;\n"
	"\t\t\t\n"
	"\t\t\t\tboneMatrix = BoneMatrixArray[boneIndex.x];\n"
	"\t\t\t\tnormalMatrix = BoneMatrixArrayIT[boneIndex.x];\n"
	"\n"
	"\t\t\t\tposition += boneMatrix * vec4(inVertex, 1.0) * boneWeights.x;\n"
	"\t\t\t\tworldNormal += normalMatrix * inNormal * boneWeights.x;\n"
	"\t\t\t\t\n"
	"\t\t\t\tif(bUseDot3)\n"
	"\t\t\t\t{\n"
	"\t\t\t\t\tworldTangent += normalMatrix * inTangent * boneWeights.x;\n"
	"\t\t\t\t\tworldBiNormal += normalMatrix * inBiNormal * boneWeights.x;\n"
	"\t\t\t\t}\n"
	"\t\t\t}\n"
	"\t\t}\t\t\n"
	"\t\tgl_Position = ViewProjMatrix * position;\n"
	"\t\t\n"
	"\t\t// lighting\n"
	"\t\tmediump vec3 TmpLightDir = normalize(LightPos - position.xyz);\n"
	"\t\t\n"
	"\t\tif(bUseDot3)\n"
	"\t\t{\n"
	"\t\t\tLight.x = dot(normalize(worldTangent), TmpLightDir);\n"
	"\t\t\tLight.y = dot(normalize(worldBiNormal), TmpLightDir);\n"
	"\t\t\tLight.z = dot(normalize(worldNormal), TmpLightDir);\n"
	"\t\t}\n"
	"\t\telse\n"
	"\t\t{\n"
	"\t\t\tLight.x = dot(normalize(worldNormal), TmpLightDir);\n"
	"\t\t}\n"
	"\t}\n"
	"\n"
	"\t\n"
	"\t// Pass through texcoords\n"
	"\tTexCoord = inTexCoord;\n"
	"}\n"
	" ";

// Register SkinnedVertShader.vsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_SkinnedVertShader_vsh("SkinnedVertShader.vsh", _SkinnedVertShader_vsh, 3431);

// ******** End: SkinnedVertShader.vsh ********

