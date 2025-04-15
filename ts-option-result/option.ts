export type Some<T> = Readonly<{
	tag: "some";
	value: T;
}>;

export type None = Readonly<{
	tag: "none";
}>;

export type Option<T> = Some<T> | None;
