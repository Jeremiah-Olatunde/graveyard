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

export type Struct<
	Key extends string = string,
	Value extends Serializable = Serializable,
> = Readonly<Record<Key, Value>>;

export function struct<T extends Struct>(blueprint: T): Readonly<T> {
	assertSerializable(blueprint);
	return blueprint;
}

export function prop<
	Key extends string,
	Value extends Serializable,
	T extends Struct<Key, Value>,
>(key: Key, struct: T): T[Key] {
	return struct[key];
}

export function propCurried<Key extends string>(key: Key) {
	return function <Value extends Serializable, T extends Struct<Key, Value>>(
		struct: T,
	) {
		return struct[key];
	};
}
