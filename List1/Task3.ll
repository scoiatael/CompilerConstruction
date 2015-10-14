; ModuleID = 'Task3.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i64 @length(i8* %s) #0 {
  %1 = alloca i8*, align 8
  %length = alloca i64, align 8
  store i8* %s, i8** %1, align 8
  store i64 0, i64* %length, align 8
  br label %2

; <label>:2                                       ; preds = %7, %0
  %3 = load i8*, i8** %1, align 8
  %4 = getelementptr inbounds i8, i8* %3, i32 1
  store i8* %4, i8** %1, align 8
  %5 = load i8, i8* %3, align 1
  %6 = icmp ne i8 %5, 0
  br i1 %6, label %7, label %10

; <label>:7                                       ; preds = %2
  %8 = load i64, i64* %length, align 8
  %9 = add i64 %8, 1
  store i64 %9, i64* %length, align 8
  br label %2

; <label>:10                                      ; preds = %2
  %11 = load i64, i64* %length, align 8
  ret i64 %11
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
