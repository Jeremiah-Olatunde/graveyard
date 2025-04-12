export function map<Item, Mapped>(
	array: readonly Item[],
	mapping: (item: Item) => Mapped,
): readonly Mapped[] {
	const [head, ...tail] = array;

	if (head === undefined) {
		return [];
	}

	return [mapping(head), ...map(tail, mapping)];
}

export function filter<Item>(
	array: readonly Item[],
	predicate: (item: Item) => boolean,
): Item[] {
	const [head, ...tail] = array;

	if (head === undefined) {
		return [];
	}

	if (predicate(head)) {
		return [head, ...filter(tail, predicate)];
	}

	return filter(tail, predicate);
}

export function fold<Item, Accum>(
	array: readonly Item[],
	initial: Accum,
	f: (accum: Accum, item: Item) => Accum,
): Accum {
	const [head, ...tail] = array;

	if (head === undefined) {
		return initial;
	}

	return fold(tail, f(initial, head), f);
}
