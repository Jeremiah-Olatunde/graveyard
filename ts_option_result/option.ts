export type Some<T> = Readonly<{
	tag: "some";
	value: T;
}>;

export type None = Readonly<{
	tag: "none";
}>;

export type Option<T> = Some<T> | None;

export function isSome<T>(option: Option<T>): option is Some<T> {
	return option.tag === "some";
}

export function isNone<T>(option: Option<T>): option is None {
	return option.tag === "none";
}

export function some<T>(value: T): Some<T> {
	return { tag: "some", value };
}

export function none(): None {
	return { tag: "none" };
}

export function map<T, U>(
	option: Option<T>,
	mapping: (value: T) => U,
): Option<U> {
	return isSome(option) ? some(mapping(option.value)) : option;
}

export function flatten<T>(option: Option<Option<T>>): Option<T> {
	if (isSome(option)) return option.value;
	return option;
}

export function partition<T>(options: Option<T>[]): [Some<T>[], None[]] {
	return [options.filter(isSome), options.filter(isNone)];
}

export function all<T>(options: Option<T>[]): Option<T[]> {
	const [somes, nones] = partition(options);
	const values = somes.map(({ value }) => value);
	if (nones.length === 0) return some(values);
	return nones[0];
}
