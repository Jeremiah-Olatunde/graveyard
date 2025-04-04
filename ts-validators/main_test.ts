import { assert, assertFalse } from "@std/assert";
import * as validators from "./main.ts";

Deno.test(function validateString() {
	assert(validators.validateString("hello world"));
	assertFalse(validators.validateString(10));
	assertFalse(validators.validateString(true));
	assertFalse(validators.validateString({ prop: "not a string" }));
});

Deno.test(function validateNumber() {
	assert(validators.validateNumber(10));
	assertFalse(validators.validateNumber("not a number"));
	assertFalse(validators.validateNumber(true));
	assertFalse(validators.validateNumber({ prop: true }));
});

Deno.test(function validateBoolean() {
	assert(validators.validateBoolean(true));
	assert(validators.validateBoolean(false));
	assertFalse(validators.validateBoolean(10));
	assertFalse(validators.validateBoolean("not a boolean"));
	assertFalse(validators.validateBoolean({ prop: 10000 }));
});
