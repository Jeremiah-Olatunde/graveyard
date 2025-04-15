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

export function partition<T>(results: Option<T>[]): [Some<T>[], None[]] {
	return [results.filter(isSome), results.filter(isNone)];
}
