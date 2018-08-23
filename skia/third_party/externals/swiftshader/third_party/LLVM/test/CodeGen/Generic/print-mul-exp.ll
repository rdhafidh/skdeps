; RUN: llc < %s

@a_str = internal constant [8 x i8] c"a = %d\0A\00"		; <[8 x i8]*> [#uses=1]
@a_mul_str = internal constant [13 x i8] c"a * %d = %d\0A\00"		; <[13 x i8]*> [#uses=1]
@A = global i32 2		; <i32*> [#uses=1]

declare i32 @printf(i8*, ...)

define i32 @main() {
	%a = load i32* @A		; <i32> [#uses=21]
	%a_s = getelementptr [8 x i8]* @a_str, i64 0, i64 0		; <i8*> [#uses=1]
	%a_mul_s = getelementptr [13 x i8]* @a_mul_str, i64 0, i64 0		; <i8*> [#uses=20]
	call i32 (i8*, ...)* @printf( i8* %a_s, i32 %a )		; <i32>:1 [#uses=0]
	%r_0 = mul i32 %a, 0		; <i32> [#uses=1]
	%r_1 = mul i32 %a, 1		; <i32> [#uses=1]
	%r_2 = mul i32 %a, 2		; <i32> [#uses=1]
	%r_3 = mul i32 %a, 3		; <i32> [#uses=1]
	%r_4 = mul i32 %a, 4		; <i32> [#uses=1]
	%r_5 = mul i32 %a, 5		; <i32> [#uses=1]
	%r_6 = mul i32 %a, 6		; <i32> [#uses=1]
	%r_7 = mul i32 %a, 7		; <i32> [#uses=1]
	%r_8 = mul i32 %a, 8		; <i32> [#uses=1]
	%r_9 = mul i32 %a, 9		; <i32> [#uses=1]
	%r_10 = mul i32 %a, 10		; <i32> [#uses=1]
	%r_11 = mul i32 %a, 11		; <i32> [#uses=1]
	%r_12 = mul i32 %a, 12		; <i32> [#uses=1]
	%r_13 = mul i32 %a, 13		; <i32> [#uses=1]
	%r_14 = mul i32 %a, 14		; <i32> [#uses=1]
	%r_15 = mul i32 %a, 15		; <i32> [#uses=1]
	%r_16 = mul i32 %a, 16		; <i32> [#uses=1]
	%r_17 = mul i32 %a, 17		; <i32> [#uses=1]
	%r_18 = mul i32 %a, 18		; <i32> [#uses=1]
	%r_19 = mul i32 %a, 19		; <i32> [#uses=1]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 0, i32 %r_0 )		; <i32>:2 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 1, i32 %r_1 )		; <i32>:3 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 2, i32 %r_2 )		; <i32>:4 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 3, i32 %r_3 )		; <i32>:5 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 4, i32 %r_4 )		; <i32>:6 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 5, i32 %r_5 )		; <i32>:7 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 6, i32 %r_6 )		; <i32>:8 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 7, i32 %r_7 )		; <i32>:9 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 8, i32 %r_8 )		; <i32>:10 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 9, i32 %r_9 )		; <i32>:11 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 10, i32 %r_10 )		; <i32>:12 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 11, i32 %r_11 )		; <i32>:13 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 12, i32 %r_12 )		; <i32>:14 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 13, i32 %r_13 )		; <i32>:15 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 14, i32 %r_14 )		; <i32>:16 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 15, i32 %r_15 )		; <i32>:17 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 16, i32 %r_16 )		; <i32>:18 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 17, i32 %r_17 )		; <i32>:19 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 18, i32 %r_18 )		; <i32>:20 [#uses=0]
	call i32 (i8*, ...)* @printf( i8* %a_mul_s, i32 19, i32 %r_19 )		; <i32>:21 [#uses=0]
	ret i32 0
}
