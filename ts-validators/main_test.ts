import { assert, assertFalse } from "@std/assert";
import * as v from "./main.ts";

Deno.test(function validateString() {
	assert(v.validateString("hello world"));
	assertFalse(v.validateString(10));
	assertFalse(v.validateString(true));
	assertFalse(v.validateString({ prop: "not a string" }));
});

Deno.test(function validateNumber() {
	assert(v.validateNumber(10));
	assertFalse(v.validateNumber("not a number"));
	assertFalse(v.validateNumber(true));
	assertFalse(v.validateNumber({ prop: true }));
});

Deno.test(function validateBoolean() {
	assert(v.validateBoolean(true));
	assert(v.validateBoolean(false));
	assertFalse(v.validateBoolean(10));
	assertFalse(v.validateBoolean("not a boolean"));
	assertFalse(v.validateBoolean({ prop: 10000 }));
});

Deno.test(function validateRecord() {
	const testValue: unknown = {
		name: "jesuseun jeremiah olatude",
		age: 23,
		married: false,
	};

	assert(v.validateRecord(testValue));
	assert(v.validateProperty(v.validateString, "name", testValue));
	assert(v.validateProperty(v.validateNumber, "age", testValue));
	assert(v.validateProperty(v.validateBoolean, "married", testValue));
});
