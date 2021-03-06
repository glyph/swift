// RUN: rm -rf %t
// RUN: mkdir -p %t
// RUN: %swift -emit-module -o %t/test_module.swiftmodule %S/Inputs/test_module.swift

// RUN: %sourcekitd-test -req=index %s -- %s -I %t | FileCheck %s

// RUN: %sourcekitd-test -req=index %t/test_module.swiftmodule | %sed_clean > %t.response
// RUN: diff -u %S/Inputs/test_module.index.response %t.response

import test_module

func foo(a: TwoInts) {
}

// CHECK:      key.kind: source.lang.swift.import.module.swift
// CHECK-NEXT: key.name: "Swift"
// CHECK-NEXT: key.filepath: "{{.*[/\\]}}Swift.swiftmodule"
// CHECK-NEXT: key.hash:

// CHECK:      key.kind: source.lang.swift.import.module.swift
// CHECK-NEXT: key.name: "test_module"
// CHECK-NEXT: key.filepath: "{{.*[/\\]}}test_module.swiftmodule"
// CHECK-NEXT: key.hash:

// CHECK:      key.kind: source.lang.swift.ref.class
// CHECK-NEXT: key.name: "TwoInts"
// CHECK-NEXT: key.usr: "s:C11test_module7TwoInts"
