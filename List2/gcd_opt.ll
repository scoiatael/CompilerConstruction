; ModuleID = 'gcd.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i64 @gcd(i64 %x, i64 %y) #0 {
  %reg5 = icmp eq i64 %x, 0
  br i1 %reg5, label %label6, label %label8

label6:                                       ; preds = %reg0
  br label %label29

label8:                                       ; preds = %reg0
  %reg10 = icmp eq i64 %y, 0
  br i1 %reg10, label %label11, label %label13

label11:                                      ; preds = %reg8
  br label %label29

label13:                                      ; preds = %reg8
  %reg16 = icmp ult i64 %x, %y
  br i1 %reg16, label %label17, label %label23

label17:                                      ; preds = %reg13
  %reg21 = sub i64 %y, %x
  %reg22 = call i64 @gcd(i64 %x, i64 %reg21)
  br label %label29

label23:                                      ; preds = %reg13
  %reg26 = sub i64 %x, %y
  %reg28 = call i64 @gcd(i64 %reg26, i64 %y)
  br label %label29

label29:                                      ; preds = %reg23, %reg17, %reg11, %reg6
  %reg30 = phi i64 [%y, %label6], [%x, %label11], [%reg22, %label17], [%reg28, %label23]
  ret i64 %reg30
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
