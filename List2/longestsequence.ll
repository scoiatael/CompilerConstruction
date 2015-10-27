; ModuleID = 'longestsequence.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [26 x i8] c"longestsequence(%ld)=%ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define i64 @longestsequence(i64 %upperbound) #0 {
  ; %reg1 = alloca i64, align 8
  ; store i64 %upperbound, i64* %reg1, align 8
  br label %label2

label2:                                       ; preds = %reg33, %reg0
  %longeststop = phi i64 [0, %0], [%ireg, %label33]
  %longesti = phi i64 [0, %0], [%reg3, %label33]
  %reg3 = phi i64 [1, %0], [%reg35, %label33]
  %reg5 = icmp ult i64 %reg3, %upperbound
  br i1 %reg5, label %label6, label %label36

label6:                                       ; preds = %reg2
  br label %label8

label8:                                       ; preds = %reg22, %reg6
  %length = phi i64 [0, %label6], [%reg24, %label22]
  %reg9 = phi i64 [%reg3, %label6], [%ireg1, %label22]
  %reg10 = icmp ne i64 %reg9, 1
  br i1 %reg10, label %label11, label %label25

label11:                                      ; preds = %reg8
  %reg13 = and i64 %reg9, 1
  %reg14 = icmp ne i64 %reg13, 0
  br i1 %reg14, label %label15, label %label19

label15:                                      ; preds = %reg11
  %reg17 = mul i64 %reg9, 3
  %reg18 = add i64 %reg17, 1
  br label %label22

label19:                                      ; preds = %reg11
  %reg21 = udiv i64 %reg9, 2
  br label %label22

label22:                                      ; preds = %reg19, %reg15
  %ireg1 = phi i64 [%reg18, %label15], [%reg21, %label19]
  %reg24 = add i64 %length, 1
  br label %label8

label25:                                      ; preds = %reg8
  %reg28 = icmp ugt i64 %length, %longeststop
  br i1 %reg28, label %label29, label %label32

label29:                                      ; preds = %reg25
  br label %label32

label32:                                      ; preds = %reg29, %reg25
  %ireg = phi i64 [%length, %label29], [%longeststop, %label25]
  br label %label33

label33:                                      ; preds = %reg32
  %reg35 = add i64 %reg3, 1
  br label %label2

label36:                                      ; preds = %reg2
  ret i64 %longesti
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %arg = alloca i64, align 8
  store i64 10, i64* %arg, align 8
  %reg1 = call i64 @longestsequence(i64 10)
  %reg2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str, i32 0, i32 0), i64 10, i64 %reg1)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
