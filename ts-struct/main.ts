import { assert } from "@std/assert";
import {
	validateString,
	validateNumber,
	validateBoolean,
	validateTypedArray,
	validateTypedRecord,
} from "./validators.ts";

export type Serializable =
	| string
	| number
	| boolean
	| Serializable[]
	| { [index: string]: Serializable };

export function isSerializable(value: unknown): value is Serializable {
	return (
		validateString(value) ||
		validateNumber(value) ||
		validateBoolean(value) ||
		validateTypedArray(isSerializable, value) ||
		validateTypedRecord(isSerializable, value)
	);
}

export function assertSerializable(
	value: unknown,
): asserts value is Serializable {
	assert(isSerializable(value));
}

export type Struct = Readonly<Record<string, Serializable>>;

export function struct<T extends Struct>(blueprint: T): Readonly<T> {
	assertSerializable(blueprint);
	return blueprint;
}
