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

export function validateUnion<T, U>(
	validatorA: Validator<T>,
	validatorB: Validator<U>,
	value: unknown,
): value is Validator<T | U> {
	return validatorA(value) || validatorB(value);
}

export function validateUnionCurried<T>(
	validatorA: Validator<T>,
): <U>(validatorB: Validator<U>) => Validator<T | U> {
	return function <U>(validatorB: Validator<U>) {
		return function (value: unknown): value is T | U {
			return validatorA(value) || validatorB(value);
		};
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

export function validatePropertyCurried<Key extends string, Value>(
	validator: Validator<Value>,
	key: Key,
) {
	return (value: unknown) => validateProperty(validator, key, value);
}
