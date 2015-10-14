; ModuleID = 'Task1.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define signext i8 @tolower1(i8 signext %c) #0 {
  %1 = alloca i8, align 1
  store i8 %c, i8* %1, align 1
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp sge i32 %3, 65
  br i1 %4, label %5, label %14

; <label>:5                                       ; preds = %0
  %6 = load i8, i8* %1, align 1
  %7 = sext i8 %6 to i32
  %8 = icmp sle i32 %7, 90
  br i1 %8, label %9, label %14

; <label>:9                                       ; preds = %5
  %10 = load i8, i8* %1, align 1
  %11 = sext i8 %10 to i32
  %12 = sub nsw i32 %11, 65
  %13 = add nsw i32 %12, 97
  br label %17

; <label>:14                                      ; preds = %5, %0
  %15 = load i8, i8* %1, align 1
  %16 = sext i8 %15 to i32
  br label %17

; <label>:17                                      ; preds = %14, %9
  %18 = phi i32 [ %13, %9 ], [ %16, %14 ]
  %19 = trunc i32 %18 to i8
  ret i8 %19
}

; Function Attrs: nounwind uwtable
define signext i8 @tolower2(i8 signext %c) #0 {
  %1 = alloca i8, align 1
  store i8 %c, i8* %1, align 1
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp sge i32 %3, 65
  br i1 %4, label %5, label %14

; <label>:5                                       ; preds = %0
  %6 = load i8, i8* %1, align 1
  %7 = sext i8 %6 to i32
  %8 = icmp sle i32 %7, 90
  br i1 %8, label %9, label %14

; <label>:9                                       ; preds = %5
  %10 = load i8, i8* %1, align 1
  %11 = sext i8 %10 to i32
  %12 = add nsw i32 %11, 32
  %13 = trunc i32 %12 to i8
  store i8 %13, i8* %1, align 1
  br label %14

; <label>:14                                      ; preds = %9, %5, %0
  %15 = load i8, i8* %1, align 1
  ret i8 %15
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
