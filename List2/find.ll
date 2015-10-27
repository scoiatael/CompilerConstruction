; ModuleID = 'find.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tree = type { double, double, %struct.tree*, %struct.tree* }

@.str = private unnamed_addr constant [11 x i8] c"Not found\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"Found: %f\0A\00", align 1

; Function Attrs: nounwind uwtable
define double* @find(double %x, %struct.tree* %t) #0 {
  %1 = alloca double*, align 8
  %2 = alloca double, align 8
  %3 = alloca %struct.tree*, align 8
  store double %x, double* %2, align 8
  store %struct.tree* %t, %struct.tree** %3, align 8
  %4 = load %struct.tree*, %struct.tree** %3, align 8
  %5 = icmp eq %struct.tree* %4, null
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  store double* null, double** %1
  br label %34

; <label>:7                                       ; preds = %0
  %8 = load %struct.tree*, %struct.tree** %3, align 8
  %9 = getelementptr inbounds %struct.tree, %struct.tree* %8, i32 0, i32 0
  %10 = load double, double* %9, align 8
  %11 = load double, double* %2, align 8
  %12 = fcmp oeq double %10, %11
  br i1 %12, label %13, label %16

; <label>:13                                      ; preds = %7
  %14 = load %struct.tree*, %struct.tree** %3, align 8
  %15 = getelementptr inbounds %struct.tree, %struct.tree* %14, i32 0, i32 1
  store double* %15, double** %1
  br label %34

; <label>:16                                      ; preds = %7
  %17 = load double, double* %2, align 8
  %18 = load %struct.tree*, %struct.tree** %3, align 8
  %19 = getelementptr inbounds %struct.tree, %struct.tree* %18, i32 0, i32 0
  %20 = load double, double* %19, align 8
  %21 = fcmp olt double %17, %20
  br i1 %21, label %22, label %28

; <label>:22                                      ; preds = %16
  %23 = load double, double* %2, align 8
  %24 = load %struct.tree*, %struct.tree** %3, align 8
  %25 = getelementptr inbounds %struct.tree, %struct.tree* %24, i32 0, i32 2
  %26 = load %struct.tree*, %struct.tree** %25, align 8
  %27 = call double* @find(double %23, %struct.tree* %26)
  store double* %27, double** %1
  br label %34

; <label>:28                                      ; preds = %16
  %29 = load double, double* %2, align 8
  %30 = load %struct.tree*, %struct.tree** %3, align 8
  %31 = getelementptr inbounds %struct.tree, %struct.tree* %30, i32 0, i32 3
  %32 = load %struct.tree*, %struct.tree** %31, align 8
  %33 = call double* @find(double %29, %struct.tree* %32)
  store double* %33, double** %1
  br label %34

; <label>:34                                      ; preds = %28, %22, %13, %6
  %35 = load double*, double** %1
  ret double* %35
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %t1 = alloca %struct.tree, align 8
  %t2 = alloca %struct.tree, align 8
  %t3 = alloca %struct.tree, align 8
  %found = alloca double*, align 8
  store i32 0, i32* %1
  %2 = getelementptr inbounds %struct.tree, %struct.tree* %t1, i32 0, i32 0
  store double 1.000000e+00, double* %2, align 8
  %3 = getelementptr inbounds %struct.tree, %struct.tree* %t1, i32 0, i32 1
  store double 1.000000e+01, double* %3, align 8
  %4 = getelementptr inbounds %struct.tree, %struct.tree* %t2, i32 0, i32 0
  store double 2.000000e+00, double* %4, align 8
  %5 = getelementptr inbounds %struct.tree, %struct.tree* %t2, i32 0, i32 1
  store double 2.000000e+01, double* %5, align 8
  %6 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 0
  store double 3.000000e+00, double* %6, align 8
  %7 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 1
  store double 3.000000e+01, double* %7, align 8
  %8 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 2
  store %struct.tree* %t1, %struct.tree** %8, align 8
  %9 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 3
  store %struct.tree* %t2, %struct.tree** %9, align 8
  %10 = call double* @find(double 1.000000e+00, %struct.tree* %t3)
  store double* %10, double** %found, align 8
  %11 = load double*, double** %found, align 8
  %12 = icmp eq double* %11, null
  br i1 %12, label %13, label %15

; <label>:13                                      ; preds = %0
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  br label %19

; <label>:15                                      ; preds = %0
  %16 = load double*, double** %found, align 8
  %17 = load double, double* %16, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0), double %17)
  br label %19

; <label>:19                                      ; preds = %15, %13
  %20 = load i32, i32* %1
  ret i32 %20
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
