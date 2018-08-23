; RUN: llc < %s
@a_str = internal constant [8 x i8] c"a = %d\0A\00"		; <[8 x i8]*> [#uses=1]
@b_str = internal constant [8 x i8] c"b = %d\0A\00"		; <[8 x i8]*> [#uses=1]
@add_str = internal constant [12 x i8] c"a + b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@sub_str = internal constant [12 x i8] c"a - b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@mul_str = internal constant [12 x i8] c"a * b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@div_str = internal constant [12 x i8] c"b / a = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@rem_str = internal constant [13 x i8] c"b \5C% a = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@lt_str = internal constant [12 x i8] c"a < b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@le_str = internal constant [13 x i8] c"a <= b = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@gt_str = internal constant [12 x i8] c"a > b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@ge_str = internal constant [13 x i8] c"a >= b = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@eq_str = internal constant [13 x i8] c"a == b = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@ne_str = internal constant [13 x i8] c"a != b = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@and_str = internal constant [12 x i8] c"a & b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@or_str = internal constant [12 x i8] c"a | b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@xor_str = internal constant [12 x i8] c"a ^ b = %d\0A\00"		; <[12 x i8]*> [#uses=1]
@shl_str = internal constant [13 x i8] c"b << a = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@shr_str = internal constant [13 x i8] c"b >> a = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@A = global i32 2		; <i32*> [#uses=1]
@B = global i32 5		; <i32*> [#uses=1]

declare i32 @printf(i8*, ...)

define i32 @main() {
	%a = load i32* @A		; <i32> [#uses=16]
	%b = load i32* @B		; <i32> [#uses=17]
	%a_s = getelementptr [8 x i8]* @a_str, i64 0, i64 0		; <i8*> [#uses=1]
	%b_s = getelementptr [8 x i8]* @b_str, i64 0, i64 0		; <i8*> [#uses=1]
	call i32 (i8*, ...)* @printf( i8* %a_s, i32 %a )		; <i32>:1 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %b_s, i32 %b )		; <i32>:2 [#uses=0]
	%add_r = add i32 %a, %b		; <i32> [#uses=1]
	%sub_r = sub i32 %a, %b		; <i32> [#uses=1]
	%mul_r = mul i32 %a, %b		; <i32> [#uses=1]
	%div_r = sdiv i32 %b, %a		; <i32> [#uses=1]
	%rem_r = srem i32 %b, %a		; <i32> [#uses=1]
	%add_s = getelementptr [12 x i8]* @add_str, i64 0, i64 0		; <i8*> [#uses=1]
	%sub_s = getelementptr [12 x i8]* @sub_str, i64 0, i64 0		; <i8*> [#uses=1]
	%mul_s = getelementptr [12 x i8]* @mul_str, i64 0, i64 0		; <i8*> [#uses=1]
	%div_s = getelementptr [12 x i8]* @div_str, i64 0, i64 0		; <i8*> [#uses=1]
	%rem_s = getelementptr [13 x i8]* @rem_str, i64 0, i64 0		; <i8*> [#uses=1]
	call i32 (i8*, ...)* @printf( i8* %add_s, i32 %add_r )		; <i32>:3 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %sub_s, i32 %sub_r )		; <i32>:4 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %mul_s, i32 %mul_r )		; <i32>:5 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %div_s, i32 %div_r )		; <i32>:6 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %rem_s, i32 %rem_r )		; <i32>:7 [#uses=0]
	%lt_r = icmp slt i32 %a, %b		; <i1> [#uses=1]
	%le_r = icmp sle i32 %a, %b		; <i1> [#uses=1]
	%gt_r = icmp sgt i32 %a, %b		; <i1> [#uses=1]
	%ge_r = icmp sge i32 %a, %b		; <i1> [#uses=1]
	%eq_r = icmp eq i32 %a, %b		; <i1> [#uses=1]
	%ne_r = icmp ne i32 %a, %b		; <i1> [#uses=1]
	%lt_s = getelementptr [12 x i8]* @lt_str, i64 0, i64 0		; <i8*> [#uses=1]
	%le_s = getelementptr [13 x i8]* @le_str, i64 0, i64 0		; <i8*> [#uses=1]
	%gt_s = getelementptr [12 x i8]* @gt_str, i64 0, i64 0		; <i8*> [#uses=1]
	%ge_s = getelementptr [13 x i8]* @ge_str, i64 0, i64 0		; <i8*> [#uses=1]
	%eq_s = getelementptr [13 x i8]* @eq_str, i64 0, i64 0		; <i8*> [#uses=1]
	%ne_s = getelementptr [13 x i8]* @ne_str, i64 0, i64 0		; <i8*> [#uses=1]
	call i32 (i8*, ...)* @printf( i8* %lt_s, i1 %lt_r )		; <i32>:8 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %le_s, i1 %le_r )		; <i32>:9 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %gt_s, i1 %gt_r )		; <i32>:10 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %ge_s, i1 %ge_r )		; <i32>:11 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %eq_s, i1 %eq_r )		; <i32>:12 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %ne_s, i1 %ne_r )		; <i32>:13 [#uses=0]
	%and_r = and i32 %a, %b		; <i32> [#uses=1]
	%or_r = or i32 %a, %b		; <i32> [#uses=1]
	%xor_r = xor i32 %a, %b		; <i32> [#uses=1]
	%u = trunc i32 %a to i8		; <i8> [#uses=2]
	%shift.upgrd.1 = zext i8 %u to i32		; <i32> [#uses=1]
	%shl_r = shl i32 %b, %shift.upgrd.1		; <i32> [#uses=1]
	%shift.upgrd.2 = zext i8 %u to i32		; <i32> [#uses=1]
	%shr_r = ashr i32 %b, %shift.upgrd.2		; <i32> [#uses=1]
	%and_s = getelementptr [12 x i8]* @and_str, i64 0, i64 0		; <i8*> [#uses=1]
	%or_s = getelementptr [12 x i8]* @or_str, i64 0, i64 0		; <i8*> [#uses=1]
	%xor_s = getelementptr [12 x i8]* @xor_str, i64 0, i64 0		; <i8*> [#uses=1]
	%shl_s = getelementptr [13 x i8]* @shl_str, i64 0, i64 0		; <i8*> [#uses=1]
	%shr_s = getelementptr [13 x i8]* @shr_str, i64 0, i64 0		; <i8*> [#uses=1]
	call i32 (i8*, ...)* @printf( i8* %and_s, i32 %and_r )		; <i32>:14 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %or_s, i32 %or_r )		; <i32>:15 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %xor_s, i32 %xor_r )		; <i32>:16 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %shl_s, i32 %shl_r )		; <i32>:17 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %shr_s, i32 %shr_r )		; <i32>:18 [#uses=0]
	ret i32 0
}
