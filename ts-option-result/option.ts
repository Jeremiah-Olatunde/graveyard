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
