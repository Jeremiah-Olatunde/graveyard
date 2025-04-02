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
	predicate: (v: unknown) => v is T,
	value: unknown,
): value is T[] {
	return Array.isArray(value) && predicate(value);
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
	predicate: (v: unknown) => v is T,
	value: unknown,
): value is Record<string, T> {
	return validateRecord(value) && Object.values(value).every(predicate);
}

export function validateUnion<T, U>(
	validatorA: (v: unknown) => v is T,
	validatorB: (v: unknown) => v is U,
	value: unknown,
): value is T | U {
	return validatorA(value) || validatorB(value);
}
