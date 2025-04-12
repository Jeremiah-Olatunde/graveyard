export function map<Item, Mapped>(
	array: readonly Item[],
	mapping: (item: Item) => Mapped,
): readonly Mapped[] {
	const [head, ...tail] = array;

	if (head === undefined) return [];
	return [mapping(head), ...map(tail, mapping)];
}
