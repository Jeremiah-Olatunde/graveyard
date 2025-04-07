type Validator<T> = (value: unknown) => value is T;

export function validateString(value: unknown): value is string {
	return typeof value === "string";
}

export function validateNumber(value: unknown): value is number {
	return typeof value === "number";
}

export function validateBoolean(value: unknown): value is boolean {
	return typeof value === "boolean";
}

export function validateArray(value: unknown): value is unknown[] {
	return Array.isArray(value);
}

export function validateTypedArray<T>(
	predicate: Validator<T>,
	value: unknown,
): value is T[] {
	return Array.isArray(value) && value.every((v) => predicate(v));
}

export function createValidatorTypedArray<T>(
	predicate: Validator<T>,
): Validator<T[]> {
	return function (value: unknown): value is T[] {
		return Array.isArray(value) && value.every((v) => predicate(v));
	};
}

export function validateRecord(
	value: unknown,
): value is Record<string, unknown> {
	return (
		value !== null &&
		typeof value === "object" &&
		Object.keys(value).every(validateString)
	);
}

export function validateTypedRecord<T>(
	predicate: Validator<T>,
	value: unknown,
): value is Record<string, T> {
	return validateRecord(value) && Object.values(value).every(predicate);
}

export function createValidatorTypedRecord<T>(
	predicate: Validator<T>,
): Validator<Record<string, T>> {
	return function (value: unknown): value is Record<string, T> {
		return validateRecord(value) && Object.values(value).every(predicate);
	};
}

export function validateProperty<Key extends string, Value>(
	validator: Validator<Value>,
	key: Key,
	value: unknown,
): value is Record<Key, Value> {
	if (validateRecord(value) && key in value) {
		return validator(value[key]);
	}

	return false;
}

export function createValidatorProperty<Key extends string, Value>(
	validator: Validator<Value>,
	key: Key,
): Validator<Record<Key, Value>> {
	return function (value: unknown): value is Record<Key, Value> {
		if (validateRecord(value) && key in value) {
			return validator(value[key]);
		}

		return false;
	};
}

export function composeValidators2<T0, T1>(
	validator0: Validator<T0>,
	validator1: Validator<T1>,
): Validator<T0 | T1> {
	return function (value: unknown): value is T0 | T1 {
		return validator0(value) || validator1(value);
	};
}

type ExtractValidatorTypes<V> = V extends Array<Validator<infer T>> ? T : never;

export function composeValidators<
	T extends Validator<unknown>,
	Args extends Array<T>,
>(...args: Args): Validator<ExtractValidatorTypes<Args>> {
	return function (value: unknown): value is ExtractValidatorTypes<Args> {
		return args.some((validator) => validator(value));
	};
}
