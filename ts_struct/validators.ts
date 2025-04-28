type Validator<T> = (value: unknown) => value is T;
export function assertSerializable(
	value: unknown,
): asserts value is Serializable {
	assert(isSerializable(value));
}

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
	return validateArray(value) && value.every((v) => predicate(v));
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
