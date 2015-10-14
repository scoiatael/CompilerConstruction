; ModuleID = 'Task4.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @mult([3 x double]* %m1, [3 x double]* %m2, [3 x double]* %m3) #0 {
  %1 = alloca [3 x double]*, align 8
  %2 = alloca [3 x double]*, align 8
  %3 = alloca [3 x double]*, align 8
  %i = alloca i64, align 8
  %j = alloca i64, align 8
  %i1 = alloca i64, align 8
  %j2 = alloca i64, align 8
  %k = alloca i64, align 8
  store [3 x double]* %m1, [3 x double]** %1, align 8
  store [3 x double]* %m2, [3 x double]** %2, align 8
  store [3 x double]* %m3, [3 x double]** %3, align 8
  store i64 0, i64* %i, align 8
  br label %4

; <label>:4                                       ; preds = %21, %0
  %5 = load i64, i64* %i, align 8
  %6 = icmp ult i64 %5, 3
  br i1 %6, label %7, label %24

; <label>:7                                       ; preds = %4
  store i64 0, i64* %j, align 8
  br label %8

; <label>:8                                       ; preds = %17, %7
  %9 = load i64, i64* %j, align 8
  %10 = icmp ult i64 %9, 3
  br i1 %10, label %11, label %20

; <label>:11                                      ; preds = %8
  %12 = load i64, i64* %j, align 8
  %13 = load i64, i64* %i, align 8
  %14 = load [3 x double]*, [3 x double]** %3, align 8
  %15 = getelementptr inbounds [3 x double], [3 x double]* %14, i64 %13
  %16 = getelementptr inbounds [3 x double], [3 x double]* %15, i32 0, i64 %12
  store double 0.000000e+00, double* %16, align 8
  br label %17

; <label>:17                                      ; preds = %11
  %18 = load i64, i64* %j, align 8
  %19 = add i64 %18, 1
  store i64 %19, i64* %j, align 8
  br label %8

; <label>:20                                      ; preds = %8
  br label %21

; <label>:21                                      ; preds = %20
  %22 = load i64, i64* %i, align 8
  %23 = add i64 %22, 1
  store i64 %23, i64* %i, align 8
  br label %4

; <label>:24                                      ; preds = %4
  store i64 0, i64* %i1, align 8
  br label %25

; <label>:25                                      ; preds = %65, %24
  %26 = load i64, i64* %i1, align 8
  %27 = icmp ult i64 %26, 3
  br i1 %27, label %28, label %68

; <label>:28                                      ; preds = %25
  store i64 0, i64* %j2, align 8
  br label %29

; <label>:29                                      ; preds = %61, %28
  %30 = load i64, i64* %j2, align 8
  %31 = icmp ult i64 %30, 3
  br i1 %31, label %32, label %64

; <label>:32                                      ; preds = %29
  store i64 0, i64* %k, align 8
  br label %33

; <label>:33                                      ; preds = %57, %32
  %34 = load i64, i64* %k, align 8
  %35 = icmp ult i64 %34, 3
  br i1 %35, label %36, label %60

; <label>:36                                      ; preds = %33
  %37 = load i64, i64* %j2, align 8
  %38 = load i64, i64* %i1, align 8
  %39 = load [3 x double]*, [3 x double]** %1, align 8
  %40 = getelementptr inbounds [3 x double], [3 x double]* %39, i64 %38
  %41 = getelementptr inbounds [3 x double], [3 x double]* %40, i32 0, i64 %37
  %42 = load double, double* %41, align 8
  %43 = load i64, i64* %k, align 8
  %44 = load i64, i64* %j2, align 8
  %45 = load [3 x double]*, [3 x double]** %2, align 8
  %46 = getelementptr inbounds [3 x double], [3 x double]* %45, i64 %44
  %47 = getelementptr inbounds [3 x double], [3 x double]* %46, i32 0, i64 %43
  %48 = load double, double* %47, align 8
  %49 = fmul double %42, %48
  %50 = load i64, i64* %k, align 8
  %51 = load i64, i64* %i1, align 8
  %52 = load [3 x double]*, [3 x double]** %3, align 8
  %53 = getelementptr inbounds [3 x double], [3 x double]* %52, i64 %51
  %54 = getelementptr inbounds [3 x double], [3 x double]* %53, i32 0, i64 %50
  %55 = load double, double* %54, align 8
  %56 = fadd double %55, %49
  store double %56, double* %54, align 8
  br label %57

; <label>:57                                      ; preds = %36
  %58 = load i64, i64* %k, align 8
  %59 = add i64 %58, 1
  store i64 %59, i64* %k, align 8
  br label %33

; <label>:60                                      ; preds = %33
  br label %61

; <label>:61                                      ; preds = %60
  %62 = load i64, i64* %j2, align 8
  %63 = add i64 %62, 1
  store i64 %63, i64* %j2, align 8
  br label %29

; <label>:64                                      ; preds = %29
  br label %65

; <label>:65                                      ; preds = %64
  %66 = load i64, i64* %i1, align 8
  %67 = add i64 %66, 1
  store i64 %67, i64* %i1, align 8
  br label %25

; <label>:68                                      ; preds = %25
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
