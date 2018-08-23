; RUN: lli %s > /dev/null

define i32 @main() {
	%int1 = add i32 0, 0		; <i32> [#uses=6]
	%int2 = add i32 0, 0		; <i32> [#uses=6]
	%long1 = add i64 0, 0		; <i64> [#uses=6]
	%long2 = add i64 0, 0		; <i64> [#uses=6]
	%sbyte1 = add i8 0, 0		; <i8> [#uses=6]
	%sbyte2 = add i8 0, 0		; <i8> [#uses=6]
	%short1 = add i16 0, 0		; <i16> [#uses=6]
	%short2 = add i16 0, 0		; <i16> [#uses=6]
	%ubyte1 = add i8 0, 0		; <i8> [#uses=6]
	%ubyte2 = add i8 0, 0		; <i8> [#uses=6]
	%uint1 = add i32 0, 0		; <i32> [#uses=6]
	%uint2 = add i32 0, 0		; <i32> [#uses=6]
	%ulong1 = add i64 0, 0		; <i64> [#uses=6]
	%ulong2 = add i64 0, 0		; <i64> [#uses=6]
	%ushort1 = add i16 0, 0		; <i16> [#uses=6]
	%ushort2 = add i16 0, 0		; <i16> [#uses=6]
	%test1 = icmp eq i8 %ubyte1, %ubyte2		; <i1> [#uses=0]
	%test2 = icmp uge i8 %ubyte1, %ubyte2		; <i1> [#uses=0]
	%test3 = icmp ugt i8 %ubyte1, %ubyte2		; <i1> [#uses=0]
	%test4 = icmp ule i8 %ubyte1, %ubyte2		; <i1> [#uses=0]
	%test5 = icmp ult i8 %ubyte1, %ubyte2		; <i1> [#uses=0]
	%test6 = icmp ne i8 %ubyte1, %ubyte2		; <i1> [#uses=0]
	%test7 = icmp eq i16 %ushort1, %ushort2		; <i1> [#uses=0]
	%test8 = icmp uge i16 %ushort1, %ushort2		; <i1> [#uses=0]
	%test9 = icmp ugt i16 %ushort1, %ushort2		; <i1> [#uses=0]
	%test10 = icmp ule i16 %ushort1, %ushort2		; <i1> [#uses=0]
	%test11 = icmp ult i16 %ushort1, %ushort2		; <i1> [#uses=0]
	%test12 = icmp ne i16 %ushort1, %ushort2		; <i1> [#uses=0]
	%test13 = icmp eq i32 %uint1, %uint2		; <i1> [#uses=0]
	%test14 = icmp uge i32 %uint1, %uint2		; <i1> [#uses=0]
	%test15 = icmp ugt i32 %uint1, %uint2		; <i1> [#uses=0]
	%test16 = icmp ule i32 %uint1, %uint2		; <i1> [#uses=0]
	%test17 = icmp ult i32 %uint1, %uint2		; <i1> [#uses=0]
	%test18 = icmp ne i32 %uint1, %uint2		; <i1> [#uses=0]
	%test19 = icmp eq i64 %ulong1, %ulong2		; <i1> [#uses=0]
	%test20 = icmp uge i64 %ulong1, %ulong2		; <i1> [#uses=0]
	%test21 = icmp ugt i64 %ulong1, %ulong2		; <i1> [#uses=0]
	%test22 = icmp ule i64 %ulong1, %ulong2		; <i1> [#uses=0]
	%test23 = icmp ult i64 %ulong1, %ulong2		; <i1> [#uses=0]
	%test24 = icmp ne i64 %ulong1, %ulong2		; <i1> [#uses=0]
	%test25 = icmp eq i8 %sbyte1, %sbyte2		; <i1> [#uses=0]
	%test26 = icmp sge i8 %sbyte1, %sbyte2		; <i1> [#uses=0]
	%test27 = icmp sgt i8 %sbyte1, %sbyte2		; <i1> [#uses=0]
	%test28 = icmp sle i8 %sbyte1, %sbyte2		; <i1> [#uses=0]
	%test29 = icmp slt i8 %sbyte1, %sbyte2		; <i1> [#uses=0]
	%test30 = icmp ne i8 %sbyte1, %sbyte2		; <i1> [#uses=0]
	%test31 = icmp eq i16 %short1, %short2		; <i1> [#uses=0]
	%test32 = icmp sge i16 %short1, %short2		; <i1> [#uses=0]
	%test33 = icmp sgt i16 %short1, %short2		; <i1> [#uses=0]
	%test34 = icmp sle i16 %short1, %short2		; <i1> [#uses=0]
	%test35 = icmp slt i16 %short1, %short2		; <i1> [#uses=0]
	%test36 = icmp ne i16 %short1, %short2		; <i1> [#uses=0]
	%test37 = icmp eq i32 %int1, %int2		; <i1> [#uses=0]
	%test38 = icmp sge i32 %int1, %int2		; <i1> [#uses=0]
	%test39 = icmp sgt i32 %int1, %int2		; <i1> [#uses=0]
	%test40 = icmp sle i32 %int1, %int2		; <i1> [#uses=0]
	%test41 = icmp slt i32 %int1, %int2		; <i1> [#uses=0]
	%test42 = icmp ne i32 %int1, %int2		; <i1> [#uses=0]
	%test43 = icmp eq i64 %long1, %long2		; <i1> [#uses=0]
	%test44 = icmp sge i64 %long1, %long2		; <i1> [#uses=0]
	%test45 = icmp sgt i64 %long1, %long2		; <i1> [#uses=0]
	%test46 = icmp sle i64 %long1, %long2		; <i1> [#uses=0]
	%test47 = icmp slt i64 %long1, %long2		; <i1> [#uses=0]
	%test48 = icmp ne i64 %long1, %long2		; <i1> [#uses=0]
	ret i32 0
}
