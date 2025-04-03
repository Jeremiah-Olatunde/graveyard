type TypePredicate<T> = (value: unknown) => value is T;

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
	predicate: TypePredicate<T>,
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
	predicate: TypePredicate<T>,
	value: unknown,
): value is Record<string, T> {
	return validateRecord(value) && Object.values(value).every(predicate);
}

export function validateUnion<T, U>(
	validatorA: TypePredicate<T>,
	validatorB: TypePredicate<U>,
	value: unknown,
): value is TypePredicate<T | U> {
	return validatorA(value) || validatorB(value);
}

export function validateUnionCurried<T>(
	validatorA: TypePredicate<T>,
): <U>(validatorB: TypePredicate<U>) => TypePredicate<T | U> {
	return function <U>(validatorB: TypePredicate<U>) {
		return function (value: unknown): value is T | U {
			return validatorA(value) || validatorB(value);
		};
	};
}

export function validateProperty<Key extends string, Value>(
	validator: TypePredicate<Value>,
	key: Key,
	value: unknown,
): value is Record<Key, Value> {
	if (typeof value === "object" && value !== null) {
		const p = Object.getOwnPropertyDescriptor(value, key);
		if (p === undefined) return false;
		return validator(p.value);
	}

	return false;
}
