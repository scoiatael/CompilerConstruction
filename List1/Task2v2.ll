; ModuleID = 'Task2v2.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define signext i8 @tolower(i8 signext %s) #0 {
  %1 = alloca i8, align 1
  store i8 %s, i8* %1, align 1
  %2 = load i8, i8* %1, align 1
  ret i8 %2
}

; Function Attrs: nounwind uwtable
define void @tolower_str(i8* %s) #0 {
  %1 = alloca i8*, align 8
  store i8* %s, i8** %1, align 8
  br label %2

; <label>:2                                       ; preds = %7, %0
  %3 = load i8*, i8** %1, align 8
  %4 = load i8, i8* %3, align 1
  %5 = sext i8 %4 to i32
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %14

; <label>:7                                       ; preds = %2
  %8 = load i8*, i8** %1, align 8
  %9 = load i8, i8* %8, align 1
  %10 = call signext i8 @tolower(i8 signext %9)
  %11 = load i8*, i8** %1, align 8
  store i8 %10, i8* %11, align 1
  %12 = load i8*, i8** %1, align 8
  %13 = getelementptr inbounds i8, i8* %12, i32 1
  store i8* %13, i8** %1, align 8
  br label %2

; <label>:14                                      ; preds = %2
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
