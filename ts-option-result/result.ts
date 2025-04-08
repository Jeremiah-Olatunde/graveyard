export type Ok<T> = {
	tag: "ok";
	value: T;
};

export type Err<E> = {
	tag: "error";
	error: E;
};

export type Result<T, E> = Ok<T> | Err<E>;

export function err<E>(error: E): Err<E> {
	return { tag: "error", error };
}

export function ok<T>(value: T): Ok<T> {
	return { tag: "ok", value };
}
