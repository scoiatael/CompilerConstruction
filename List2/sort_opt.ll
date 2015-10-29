; ModuleID = 'sort.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.table = private unnamed_addr constant [4 x i32] [i32 10, i32 2, i32 0, i32 4], align 16
@.str = private unnamed_addr constant [9 x i8] c"%d : %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @sort(i32* %ptr1, i32* readnone %ptr2) #0 {
  %reg5.2 = icmp ult i32* %ptr1, %ptr2
  br i1 %reg5.2, label %label7.preheader, label %label38

label7.preheader:                                 ; preds = %0
  %ptr19 = ptrtoint i32* %ptr1 to i64
  %ptr28 = bitcast i32* %ptr2 to i8*
  %1 = xor i64 %ptr19, -1
  %uglygep = getelementptr i8, i8* %ptr28, i64 %1
  %uglygep10 = ptrtoint i8* %uglygep to i64
  %2 = lshr i64 %uglygep10, 2
  %3 = and i64 %2, 1
  %lcmp.mod = icmp eq i64 %3, 0
  br i1 %lcmp.mod, label %label7.prol, label %label7.preheader.split

label7.prol:                                      ; preds = %label7.preheader
  br label %label13.outer.prol

label13.outer.prol:                               ; preds = %label22.prol, %label7.prol
  %ptr1.sink.ph.prol = phi i32* [ %reg12.prol, %label22.prol ], [ %ptr1, %label7.prol ]
  %imin.ph.prol = load i32, i32* %ptr1, align 4
  br label %label13.prol

label13.prol:                                     ; preds = %label17.prol, %label13.outer.prol
  %ptr1.sink.prol = phi i32* [ %reg12.prol, %label17.prol ], [ %ptr1.sink.ph.prol, %label13.outer.prol ]
  %reg12.prol = getelementptr inbounds i32, i32* %ptr1.sink.prol, i64 1
  %reg16.prol = icmp ult i32* %reg12.prol, %ptr2
  br i1 %reg16.prol, label %label17.prol, label %label34.prol

label34.prol:                                     ; preds = %label13.prol
  %reg36.prol = getelementptr inbounds i32, i32* %ptr1, i64 1
  br label %label7.preheader.split

label17.prol:                                     ; preds = %label13.prol
  %reg19.prol = load i32, i32* %reg12.prol, align 4
  %reg21.prol = icmp ult i32 %reg19.prol, %imin.ph.prol
  br i1 %reg21.prol, label %label22.prol, label %label13.prol

label22.prol:                                     ; preds = %label17.prol
  store i32 %reg19.prol, i32* %ptr1, align 4
  store i32 %imin.ph.prol, i32* %reg12.prol, align 4
  br label %label13.outer.prol

label7.preheader.split:                           ; preds = %label34.prol, %label7.preheader
  %ptr1.tr3.unr = phi i32* [ %ptr1, %label7.preheader ], [ %reg36.prol, %label34.prol ]
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %label38.loopexit, label %label7.preheader.split.split

label7.preheader.split.split:                     ; preds = %label7.preheader.split
  br label %label7

label7:                                           ; preds = %label34.1, %label7.preheader.split.split
  %ptr1.tr3 = phi i32* [ %ptr1.tr3.unr, %label7.preheader.split.split ], [ %reg36.1, %label34.1 ]
  br label %label13.outer

label13.outer:                                    ; preds = %label22, %label7
  %ptr1.sink.ph = phi i32* [ %reg12.lcssa11, %label22 ], [ %ptr1.tr3, %label7 ]
  %imin.ph = load i32, i32* %ptr1.tr3, align 4
  br label %label13

label13:                                          ; preds = %label13.outer, %label17
  %ptr1.sink = phi i32* [ %reg12, %label17 ], [ %ptr1.sink.ph, %label13.outer ]
  %reg12 = getelementptr inbounds i32, i32* %ptr1.sink, i64 1
  %reg16 = icmp ult i32* %reg12, %ptr2
  br i1 %reg16, label %label17, label %label34

label17:                                          ; preds = %label13
  %reg19 = load i32, i32* %reg12, align 4
  %reg21 = icmp ult i32 %reg19, %imin.ph
  br i1 %reg21, label %label22, label %label13

label22:                                          ; preds = %label17
  %reg19.lcssa = phi i32 [ %reg19, %label17 ]
  %reg12.lcssa11 = phi i32* [ %reg12, %label17 ]
  store i32 %reg19.lcssa, i32* %ptr1.tr3, align 4
  store i32 %imin.ph, i32* %reg12.lcssa11, align 4
  br label %label13.outer

label34:                                          ; preds = %label13
  %reg36 = getelementptr inbounds i32, i32* %ptr1.tr3, i64 1
  br label %label13.outer.1

label38.loopexit.unr-lcssa:                       ; preds = %label34.1
  br label %label38.loopexit

label38.loopexit:                                 ; preds = %label7.preheader.split, %label38.loopexit.unr-lcssa
  br label %label38

label38:                                          ; preds = %label38.loopexit, %0
  ret void

label13.outer.1:                                  ; preds = %label22.1, %label34
  %ptr1.sink.ph.1 = phi i32* [ %reg12.1.lcssa12, %label22.1 ], [ %reg36, %label34 ]
  %imin.ph.1 = load i32, i32* %reg36, align 4
  br label %label13.1

label13.1:                                        ; preds = %label17.1, %label13.outer.1
  %ptr1.sink.1 = phi i32* [ %reg12.1, %label17.1 ], [ %ptr1.sink.ph.1, %label13.outer.1 ]
  %reg12.1 = getelementptr inbounds i32, i32* %ptr1.sink.1, i64 1
  %reg16.1 = icmp ult i32* %reg12.1, %ptr2
  br i1 %reg16.1, label %label17.1, label %label34.1

label34.1:                                        ; preds = %label13.1
  %reg36.1 = getelementptr inbounds i32, i32* %ptr1.tr3, i64 2
  %reg5.1 = icmp ult i32* %reg36.1, %ptr2
  br i1 %reg5.1, label %label7, label %label38.loopexit.unr-lcssa

label17.1:                                        ; preds = %label13.1
  %reg19.1 = load i32, i32* %reg12.1, align 4
  %reg21.1 = icmp ult i32 %reg19.1, %imin.ph.1
  br i1 %reg21.1, label %label22.1, label %label13.1

label22.1:                                        ; preds = %label17.1
  %reg19.1.lcssa = phi i32 [ %reg19.1, %label17.1 ]
  %reg12.1.lcssa12 = phi i32* [ %reg12.1, %label17.1 ]
  store i32 %reg19.1.lcssa, i32* %reg36, align 4
  store i32 %imin.ph.1, i32* %reg12.1.lcssa12, align 4
  br label %label13.outer.1
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
label7.i:
  %table = alloca [4 x i32], align 16
  %reg2 = bitcast [4 x i32]* %table to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %reg2, i8* bitcast ([4 x i32]* @main.table to i8*), i64 16, i32 16, i1 false)
  %reg3 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 0
  %reg5 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 4
  br label %label13.outer.i

label13.outer.i:                                  ; preds = %label22.i, %label7.i
  %imin.ph.i = phi i32 [ %imin.ph.i.pre, %label22.i ], [ 10, %label7.i ]
  %ptr1.sink.ph.i = phi i32* [ %reg12.i.lcssa20, %label22.i ], [ %reg3, %label7.i ]
  br label %label13.i

label13.i:                                        ; preds = %label17.i, %label13.outer.i
  %ptr1.sink.i = phi i32* [ %reg12.i, %label17.i ], [ %ptr1.sink.ph.i, %label13.outer.i ]
  %reg12.i = getelementptr inbounds i32, i32* %ptr1.sink.i, i64 1
  %reg16.i = icmp ult i32* %reg12.i, %reg5
  br i1 %reg16.i, label %label17.i, label %label34.i

label17.i:                                        ; preds = %label13.i
  %reg19.i = load i32, i32* %reg12.i, align 4
  %reg21.i = icmp ult i32 %reg19.i, %imin.ph.i
  br i1 %reg21.i, label %label22.i, label %label13.i

label22.i:                                        ; preds = %label17.i
  %reg19.i.lcssa = phi i32 [ %reg19.i, %label17.i ]
  %reg12.i.lcssa20 = phi i32* [ %reg12.i, %label17.i ]
  store i32 %reg19.i.lcssa, i32* %reg3, align 16
  store i32 %imin.ph.i, i32* %reg12.i.lcssa20, align 4
  %imin.ph.i.pre = load i32, i32* %reg3, align 16
  br label %label13.outer.i

label34.i:                                        ; preds = %label13.i
  %reg36.i = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 1
  br label %label13.outer.i.1

label13.outer.i.1:                                ; preds = %label22.i.1, %label34.i
  %ptr1.sink.ph.i.1 = phi i32* [ %reg12.i.1.lcssa19, %label22.i.1 ], [ %reg36.i, %label34.i ]
  %imin.ph.i.1 = load i32, i32* %reg36.i, align 4
  br label %label13.i.1

label13.i.1:                                      ; preds = %label17.i.1, %label13.outer.i.1
  %ptr1.sink.i.1 = phi i32* [ %reg12.i.1, %label17.i.1 ], [ %ptr1.sink.ph.i.1, %label13.outer.i.1 ]
  %reg12.i.1 = getelementptr inbounds i32, i32* %ptr1.sink.i.1, i64 1
  %reg16.i.1 = icmp ult i32* %reg12.i.1, %reg5
  br i1 %reg16.i.1, label %label17.i.1, label %label34.i.1

label34.i.1:                                      ; preds = %label13.i.1
  %reg36.i.1 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 2
  br label %label13.outer.i.2

label17.i.1:                                      ; preds = %label13.i.1
  %reg19.i.1 = load i32, i32* %reg12.i.1, align 4
  %reg21.i.1 = icmp ult i32 %reg19.i.1, %imin.ph.i.1
  br i1 %reg21.i.1, label %label22.i.1, label %label13.i.1

label22.i.1:                                      ; preds = %label17.i.1
  %reg19.i.1.lcssa = phi i32 [ %reg19.i.1, %label17.i.1 ]
  %reg12.i.1.lcssa19 = phi i32* [ %reg12.i.1, %label17.i.1 ]
  store i32 %reg19.i.1.lcssa, i32* %reg36.i, align 4
  store i32 %imin.ph.i.1, i32* %reg12.i.1.lcssa19, align 4
  br label %label13.outer.i.1

label13.outer.i.2:                                ; preds = %label22.i.2, %label34.i.1
  %ptr1.sink.ph.i.2 = phi i32* [ %reg12.i.2.lcssa18, %label22.i.2 ], [ %reg36.i.1, %label34.i.1 ]
  %imin.ph.i.2 = load i32, i32* %reg36.i.1, align 8
  br label %label13.i.2

label13.i.2:                                      ; preds = %label17.i.2, %label13.outer.i.2
  %ptr1.sink.i.2 = phi i32* [ %reg12.i.2, %label17.i.2 ], [ %ptr1.sink.ph.i.2, %label13.outer.i.2 ]
  %reg12.i.2 = getelementptr inbounds i32, i32* %ptr1.sink.i.2, i64 1
  %reg16.i.2 = icmp ult i32* %reg12.i.2, %reg5
  br i1 %reg16.i.2, label %label17.i.2, label %label34.i.2

label34.i.2:                                      ; preds = %label13.i.2
  %reg36.i.2 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 3
  br label %label13.outer.i.3

label17.i.2:                                      ; preds = %label13.i.2
  %reg19.i.2 = load i32, i32* %reg12.i.2, align 4
  %reg21.i.2 = icmp ult i32 %reg19.i.2, %imin.ph.i.2
  br i1 %reg21.i.2, label %label22.i.2, label %label13.i.2

label22.i.2:                                      ; preds = %label17.i.2
  %reg19.i.2.lcssa = phi i32 [ %reg19.i.2, %label17.i.2 ]
  %reg12.i.2.lcssa18 = phi i32* [ %reg12.i.2, %label17.i.2 ]
  store i32 %reg19.i.2.lcssa, i32* %reg36.i.1, align 8
  store i32 %imin.ph.i.2, i32* %reg12.i.2.lcssa18, align 4
  br label %label13.outer.i.2

label13.outer.i.3:                                ; preds = %label22.i.3, %label34.i.2
  %ptr1.sink.ph.i.3 = phi i32* [ %reg12.i.3.lcssa17, %label22.i.3 ], [ %reg36.i.2, %label34.i.2 ]
  %imin.ph.i.3 = load i32, i32* %reg36.i.2, align 4
  br label %label13.i.3

label13.i.3:                                      ; preds = %label17.i.3, %label13.outer.i.3
  %ptr1.sink.i.3 = phi i32* [ %reg12.i.3, %label17.i.3 ], [ %ptr1.sink.ph.i.3, %label13.outer.i.3 ]
  %reg12.i.3 = getelementptr inbounds i32, i32* %ptr1.sink.i.3, i64 1
  %reg16.i.3 = icmp ult i32* %reg12.i.3, %reg5
  br i1 %reg16.i.3, label %label17.i.3, label %label34.i.3

label34.i.3:                                      ; preds = %label13.i.3
  %reg14 = load i32, i32* %reg3, align 16
  %reg15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 0, i32 %reg14) #1
  %reg13.1 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 1
  %reg14.1 = load i32, i32* %reg13.1, align 4
  %reg15.1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 1, i32 %reg14.1) #1
  %reg13.2 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 2
  %reg14.2 = load i32, i32* %reg13.2, align 8
  %reg15.2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 2, i32 %reg14.2) #1
  %reg13.3 = getelementptr inbounds [4 x i32], [4 x i32]* %table, i64 0, i64 3
  %reg14.3 = load i32, i32* %reg13.3, align 4
  %reg15.3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 3, i32 %reg14.3) #1
  ret i32 0

label17.i.3:                                      ; preds = %label13.i.3
  %reg19.i.3 = load i32, i32* %reg12.i.3, align 4
  %reg21.i.3 = icmp ult i32 %reg19.i.3, %imin.ph.i.3
  br i1 %reg21.i.3, label %label22.i.3, label %label13.i.3

label22.i.3:                                      ; preds = %label17.i.3
  %reg19.i.3.lcssa = phi i32 [ %reg19.i.3, %label17.i.3 ]
  %reg12.i.3.lcssa17 = phi i32* [ %reg12.i.3, %label17.i.3 ]
  store i32 %reg19.i.3.lcssa, i32* %reg36.i.2, align 4
  store i32 %imin.ph.i.3, i32* %reg12.i.3.lcssa17, align 4
  br label %label13.outer.i.3
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0 (tags/RELEASE_370/final)"}
