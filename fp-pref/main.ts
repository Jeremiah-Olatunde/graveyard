export function map<T, U>(
	array: readonly T[],
	mapping: (item: T) => U,
): readonly U[] {
	const [head, ...tail] = array;

	if (head === undefined) return [];
	return [mapping(head), ...map(tail, mapping)];
}
