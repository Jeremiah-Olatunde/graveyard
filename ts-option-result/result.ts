export type Ok<T> = {
	tag: "ok";
	value: T;
};

export type Err<E> = {
	tag: "error";
	error: E;
};

export type Result<T, E> = Ok<T> | Err<E>;
