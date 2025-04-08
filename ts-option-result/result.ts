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

export function map<T, U, E>(
	result: Result<T, E>,
	f: (value: T) => U,
): Result<U, E> {
	if (isOk(result)) return ok(f(result.value));
	return result;
}

export function mapErr<T, R, E>(
	result: Result<T, E>,
	f: (value: E) => R,
): Result<T, R> {
	if (isErr(result)) return err(f(result.error));
	return result;
}

export function isOk<T, E>(result: Result<T, E>): result is Ok<T> {
	return result.tag === "ok";
}

export function isErr<T, E>(result: Result<T, E>): result is Err<E> {
	return result.tag === "error";
}

export function partition<T, E>(results: Result<T, E>[]): [Ok<T>[], Err<E>[]] {
	return [results.filter(isOk), results.filter(isErr)];
}
