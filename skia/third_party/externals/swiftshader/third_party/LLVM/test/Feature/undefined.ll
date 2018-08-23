; RUN: llvm-as < %s | llvm-dis > %t1.ll
; RUN: llvm-as %t1.ll -o - | llvm-dis > %t2.ll
; RUN: diff %t1.ll %t2.ll

@X = global i32 undef           ; <i32*> [#uses=0]

declare i32 @atoi(i8*)

define i32 @test() {
        ret i32 undef
}

define i32 @test2() {
        %X = add i32 undef, 1           ; <i32> [#uses=1]
        ret i32 %X
}

