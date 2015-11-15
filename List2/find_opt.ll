; ModuleID = 'find.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tree = type { double, double, %struct.tree*, %struct.tree* }

@.str.1 = private unnamed_addr constant [11 x i8] c"Found: %f\0A\00", align 1
@str = private unnamed_addr constant [10 x i8] c"Not found\00"

; Function Attrs: nounwind readonly uwtable
define double* @find(double %x, %struct.tree* readonly %t) #0 {
  %reg5.2 = icmp eq %struct.tree* %t, null
  br i1 %reg5.2, label %label34, label %label7.preheader

label7.preheader:                                 ; preds = %0
  br label %label7

label7:                                           ; preds = %label7.preheader, %label16
  %t.tr3 = phi %struct.tree* [ %t.tr.be, %label16 ], [ %t, %label7.preheader ]
  %reg9 = getelementptr inbounds %struct.tree, %struct.tree* %t.tr3, i64 0, i32 0
  %reg10 = load double, double* %reg9, align 8
  %reg12 = fcmp oeq double %reg10, %x
  br i1 %reg12, label %label13, label %label16

label13:                                          ; preds = %label7
  %t.tr3.lcssa = phi %struct.tree* [ %t.tr3, %label7 ]
  %reg15 = getelementptr inbounds %struct.tree, %struct.tree* %t.tr3.lcssa, i64 0, i32 1
  br label %label34

label16:                                          ; preds = %label7
  %reg21 = fcmp ogt double %reg10, %x
  %reg25 = getelementptr inbounds %struct.tree, %struct.tree* %t.tr3, i64 0, i32 2
  %reg31 = getelementptr inbounds %struct.tree, %struct.tree* %t.tr3, i64 0, i32 3
  %t.tr.be.in = select i1 %reg21, %struct.tree** %reg25, %struct.tree** %reg31
  %t.tr.be = load %struct.tree*, %struct.tree** %t.tr.be.in, align 8
  %reg5 = icmp eq %struct.tree* %t.tr.be, null
  br i1 %reg5, label %label34.loopexit, label %label7

label34.loopexit:                                 ; preds = %label16
  br label %label34

label34:                                          ; preds = %label34.loopexit, %0, %label13
  %reg35 = phi double* [ %reg15, %label13 ], [ null, %0 ], [ null, %label34.loopexit ]
  ret double* %reg35
}

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  %t1 = alloca %struct.tree, align 16
  %t2 = alloca %struct.tree, align 16
  %t3 = alloca %struct.tree, align 16
  %1 = bitcast %struct.tree* %t1 to <2 x double>*
  store <2 x double> <double 1.000000e+00, double 1.000000e+01>, <2 x double>* %1, align 16
  %2 = bitcast %struct.tree* %t2 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+01>, <2 x double>* %2, align 16
  %3 = bitcast %struct.tree* %t3 to <2 x double>*
  store <2 x double> <double 3.000000e+00, double 3.000000e+01>, <2 x double>* %3, align 16
  %reg8 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i64 0, i32 2
  store %struct.tree* %t1, %struct.tree** %reg8, align 16
  %reg9 = getelementptr inbounds %struct.tree, %struct.tree* %t3, i64 0, i32 3
  store %struct.tree* %t2, %struct.tree** %reg9, align 8
  br label %label16.i

label16.i:                                        ; preds = %0, %label16.i.label7.i_crit_edge
  %t.tr3.i8 = phi %struct.tree* [ %t3, %0 ], [ %t.tr.be.i, %label16.i.label7.i_crit_edge ]
  %reg10.i7 = phi double [ 3.000000e+00, %0 ], [ %reg10.i.pre, %label16.i.label7.i_crit_edge ]
  %reg21.i = fcmp ogt double %reg10.i7, 1.000000e+00
  %reg25.i = getelementptr inbounds %struct.tree, %struct.tree* %t.tr3.i8, i64 0, i32 2
  %reg31.i = getelementptr inbounds %struct.tree, %struct.tree* %t.tr3.i8, i64 0, i32 3
  %t.tr.be.in.i = select i1 %reg21.i, %struct.tree** %reg25.i, %struct.tree** %reg31.i
  %t.tr.be.i = load %struct.tree*, %struct.tree** %t.tr.be.in.i, align 8
  %reg5.i = icmp eq %struct.tree* %t.tr.be.i, null
  br i1 %reg5.i, label %label13, label %label16.i.label7.i_crit_edge

label16.i.label7.i_crit_edge:                     ; preds = %label16.i
  %reg9.i.phi.trans.insert = getelementptr inbounds %struct.tree, %struct.tree* %t.tr.be.i, i64 0, i32 0
  %reg10.i.pre = load double, double* %reg9.i.phi.trans.insert, align 8
  %reg12.i = fcmp oeq double %reg10.i.pre, 1.000000e+00
  br i1 %reg12.i, label %label15, label %label16.i

label13:                                          ; preds = %label16.i
  %puts = call i32 @puts(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str, i64 0, i64 0))
  br label %label19

label15:                                          ; preds = %label16.i.label7.i_crit_edge
  %t.tr.be.i.lcssa10 = phi %struct.tree* [ %t.tr.be.i, %label16.i.label7.i_crit_edge ]
  %reg15.i = getelementptr inbounds %struct.tree, %struct.tree* %t.tr.be.i.lcssa10, i64 0, i32 1
  %reg17 = load double, double* %reg15.i, align 8
  %reg18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0), double %reg17) #3
  br label %label19

label19:                                          ; preds = %label15, %label13
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind readonly uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
