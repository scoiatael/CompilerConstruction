; ModuleID = 'sort.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.table = private unnamed_addr constant [4 x i32] [i32 10, i32 2, i32 0, i32 4], align 16
@.str = private unnamed_addr constant [9 x i8] c"%d : %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @sort(i32* %ptr1, i32* %ptr2) #0 {
  %reg5 = icmp uge i32* %ptr1, %ptr2
  br i1 %reg5, label %label6, label %label7

label6:                                       ; preds = %reg0
  br label %label38

label7:                                       ; preds = %reg0
  %reg10 = load i32, i32* %ptr1, align 4
  %reg12 = getelementptr inbounds i32, i32* %ptr1, i32 1
  br label %label13

label13:                                      ; preds = %reg31, %reg7
  %imin = phi i32 [%reg10, %label7], [%ireg2, %label31]
  %reg14 = phi i32* [%reg12, %label7], [%reg33, %label31]
  %reg16 = icmp ult i32* %reg14, %ptr2
  br i1 %reg16, label %label17, label %label34

label17:                                      ; preds = %reg13
  %reg19 = load i32, i32* %reg14, align 4
  %reg21 = icmp ult i32 %reg19, %imin
  br i1 %reg21, label %label22, label %label30

label22:                                      ; preds = %reg17
  %reg24 = load i32, i32* %reg14, align 4
  store i32 %reg24, i32* %ptr1, align 4
  store i32 %imin, i32* %reg14, align 4
  %reg29 = load i32, i32* %ptr1, align 4
  br label %label30

label30:                                      ; preds = %reg22, %reg17
  %ireg2 = phi i32 [%imin, %label17], [%reg29, %label22]
  %ireg1 = phi i32* [%reg14, %label22], [%reg14, %label17]
  br label %label31

label31:                                      ; preds = %reg30
  %reg33 = getelementptr inbounds i32, i32* %ireg1, i32 1
  br label %label13

label34:                                      ; preds = %reg13
  %reg36 = getelementptr inbounds i32, i32* %ptr1, i64 1
  call void @sort(i32* %reg36, i32* %ptr2)
  br label %label38

label38:                                      ; preds = %reg34, %reg6
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %reg1 = alloca i32, align 4
  %table_size = alloca i32, align 4
  %table = alloca [4 x i32], align 16
  %i = alloca i32, align 4
  store i32 0, i32* %reg1
  store i32 4, i32* %table_size, align 4
  %reg2 = bitcast [4 x i32]* %table to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %reg2, i8* bitcast ([4 x i32]* @main.table to i8*), i64 16, i32 16, i1 false)
  %reg3 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i32 0, i32 0
  %reg4 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i32 0, i32 0
  %reg5 = getelementptr inbounds i32, i32* %reg4, i64 4
  call void @sort(i32* %reg3, i32* %reg5)
  store i32 0, i32* %i, align 4
  br label %label6

label6:                                       ; preds = %reg16, %reg0
  %reg7 = load i32, i32* %i, align 4
  %reg8 = icmp slt i32 %reg7, 4
  br i1 %reg8, label %label9, label %label19

label9:                                       ; preds = %reg6
  %reg10 = load i32, i32* %i, align 4
  %reg11 = load i32, i32* %i, align 4
  %reg12 = sext i32 %reg11 to i64
  %reg13 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i32 0, i64 %reg12
  %reg14 = load i32, i32* %reg13, align 4
  %reg15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0), i32 %reg10, i32 %reg14)
  br label %label16

label16:                                      ; preds = %reg9
  %reg17 = load i32, i32* %i, align 4
  %reg18 = add nsw i32 %reg17, 1
  store i32 %reg18, i32* %i, align 4
  br label %label6

label19:                                      ; preds = %reg6
  %reg20 = load i32, i32* %reg1
  ret i32 %reg20
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
