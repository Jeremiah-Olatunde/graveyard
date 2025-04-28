type Assertion<T> = (value: unknown) => asserts value is T;

export function assertNonNullable(value: unknown): asserts value {
	if (!(value === null || value === undefined)) return;
	const message = "value is not of type `null | undefined`";
	throw new Error(`[ASSERTION FAILURE]: ${message}`);
}

export function assertNumber(value: unknown): asserts value is number {
	if (typeof value === "number") return;
	const message = "value is not of type `number`";
	throw new Error(`[ASSERTION FAILURE]: ${message}`);
}

export function assertBoolean(value: unknown): asserts value is boolean {
	if (typeof value === "boolean") return;
	const message = "value is not of type `boolean`";
	throw new Error(`[ASSERTION FAILURE]: ${message}`);
}

export function assertString(value: unknown): asserts value is string {
	if (typeof value === "string") return;
	const message = "value is not of type `string`";
	throw new Error(`[ASSERTION FAILURE]: ${message}`);
}

export function assertArray(value: unknown): asserts value is unknown[] {
	if (Array.isArray(value)) return;
	const message = "value is not of type `Array<_>`";
	throw new Error(`[ASSERTION FAILURE]: ${message}`);
}

export function assertArrayTyped<T>(
	assertion: Assertion<T>,
	value: unknown,
): asserts value is T[] {
	assertArray(value);
	value.forEach(assertion);
}

export function assertRecord(
	value: unknown,
): asserts value is Record<string, unknown> {
	if (value !== null && typeof value === "object") return;
	const message = "value is not of type `Record<string, _>`";
	throw new Error(`[ASSERTION FAILURE]: ${message}`);
}

export function assertRecordTyped<T>(
	assertion: Assertion<T>,
	value: unknown,
): asserts value is Record<string, T> {
	assertRecord(value);
	Object.values(value).forEach(assertion);
}

export function assertRecordProperty<Key extends string, Value>(
	assertion: Assertion<Value>,
	key: Key,
	value: unknown,
): asserts value is Record<Key, Value> {
	assertRecord(value);
	assertion(value[key]);
}
