;;! target = "s390x"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation=false -W memory64 -O static-memory-forced -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0xffff0000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load8_u offset=0xffff0000))

;; wasm[0]::function[0]:
;;       lg      %r1, 8(%r2)
;;       lg      %r1, 0(%r1)
;;       la      %r1, 0xa0(%r1)
;;       clgrtle %r15, %r1
;;       stmg    %r14, %r15, 0x70(%r15)
;;       lgr     %r1, %r15
;;       aghi    %r15, -0xa0
;;       stg     %r1, 0(%r15)
;;       clgfi   %r4, 0xffff
;;       jgh     0x4a
;;       ag      %r4, 0x60(%r2)
;;       llilh   %r3, 0xffff
;;       stc     %r5, 0(%r3, %r4)
;;       lmg     %r14, %r15, 0x110(%r15)
;;       br      %r14
;;       .byte   0x00, 0x00
;;
;; wasm[0]::function[1]:
;;       lg      %r1, 8(%r2)
;;       lg      %r1, 0(%r1)
;;       la      %r1, 0xa0(%r1)
;;       clgrtle %r15, %r1
;;       stmg    %r14, %r15, 0x70(%r15)
;;       lgr     %r1, %r15
;;       aghi    %r15, -0xa0
;;       stg     %r1, 0(%r15)
;;       clgfi   %r4, 0xffff
;;       jgh     0x98
;;       ag      %r4, 0x60(%r2)
;;       llilh   %r3, 0xffff
;;       llc     %r2, 0(%r3, %r4)
;;       lmg     %r14, %r15, 0x110(%r15)
;;       br      %r14
;;       .byte   0x00, 0x00
