; ModuleID = 'find.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tree = type { double, double, %struct.tree*, %struct.tree* }

@.str = private unnamed_addr constant [11 x i8] c"Not found\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"Found: %f\0A\00", align 1

; Function Attrs: nounwind uwtable
define double* @find(double %x, %struct.tree* %t) #0 {
  %reg5 = icmp eq %struct.tree* %t, null
  br i1 %reg5, label %label6, label %label7

label6:                                       ; preds = %reg0
  br label %label34

label7:                                       ; preds = %reg0
  %reg9 = getelementptr inbounds %struct.tree, %struct.tree* %t, i32 0, i32 0
  %reg10 = load double, double* %reg9, align 8
  %reg12 = fcmp oeq double %reg10, %x
  br i1 %reg12, label %label13, label %label16

label13:                                      ; preds = %reg7
  %reg15 = getelementptr inbounds %struct.tree, %struct.tree* %t, i32 0, i32 1
  br label %label34

label16:                                      ; preds = %reg7
  %reg19 = getelementptr inbounds %struct.tree, %struct.tree* %t, i32 0, i32 0
  %reg20 = load double, double* %reg19, align 8
  %reg21 = fcmp olt double %x, %reg20
  br i1 %reg21, label %label22, label %label28

label22:                                      ; preds = %reg16
  %reg25 = getelementptr inbounds %struct.tree, %struct.tree* %t, i32 0, i32 2
  %reg26 = load %struct.tree*, %struct.tree** %reg25, align 8
  %reg27 = call double* @find(double %x, %struct.tree* %reg26)
  br label %label34

label28:                                      ; preds = %reg16
  %reg31 = getelementptr inbounds %struct.tree, %struct.tree* %t, i32 0, i32 3
  %reg32 = load %struct.tree*, %struct.tree** %reg31, align 8
  %reg33 = call double* @find(double %x, %struct.tree* %reg32)
  br label %label34

label34:                                      ; preds = %reg28, %reg22, %reg13, %reg6
  %reg35 = phi double* [null, %label6], [%reg15, %label13], [%reg27, %label22], [%reg33, %label28]
  ret double* %reg35
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %reg1 = alloca i32, align 4
  %t1 = alloca %struct.tree, align 8
  %t2 = alloca %struct.tree, align 8
  %t3 = alloca %struct.tree, align 8
  %found = alloca double*, align 8
  store i32 0, i32* %reg1
  %reg2 = getelementptr inbounds %struct.tree, %struct.tree* %t1, i32 0, i32 0
  store double 1.000000e+00, double* %reg2, align 8
  %reg3 = getelementptr inbounds %struct.tree, %struct.tree* %t1, i32 0, i32 1
  store double 1.000000e+01, double* %reg3, align 8
  %reg4 = getelementptr inbounds %struct.tree, %struct.tree* %t2, i32 0, i32 0
  store double 2.000000e+00, double* %reg4, align 8
  %reg5 = getelementptr inbounds %struct.tree, %struct.tree* %t2, i32 0, i32 1
  store double 2.000000e+01, double* %reg5, align 8
  %reg6 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 0
  store double 3.000000e+00, double* %reg6, align 8
  %reg7 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 1
  store double 3.000000e+01, double* %reg7, align 8
  %reg8 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 2
  store %struct.tree* %t1, %struct.tree** %reg8, align 8
  %reg9 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i32 0, i32 3
  store %struct.tree* %t2, %struct.tree** %reg9, align 8
  %reg10 = call double* @find(double 1.000000e+00, %struct.tree* %t3)
  store double* %reg10, double** %found, align 8
  %reg11 = load double*, double** %found, align 8
  %reg12 = icmp eq double* %reg11, null
  br i1 %reg12, label %label13, label %label15

label13:                                      ; preds = %reg0
  %reg14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  br label %label19

label15:                                      ; preds = %reg0
  %reg16 = load double*, double** %found, align 8
  %reg17 = load double, double* %reg16, align 8
  %reg18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0), double %reg17)
  br label %label19

label19:                                      ; preds = %reg15, %reg13
  %reg20 = load i32, i32* %reg1
  ret i32 %reg20
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
