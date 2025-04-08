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
	switch (result.tag) {
		case "ok":
			return ok(f(result.value));
		case "error":
			return result;
	}
}

export function mapErr<T, R, E>(
	result: Result<T, E>,
	f: (value: E) => R,
): Result<T, R> {
	switch (result.tag) {
		case "ok":
			return result;
		case "error":
			return err(f(result.error));
	}
}

export function isOk<T, E>(result: Result<T, E>): result is Ok<T> {
	return result.tag === "ok";
}

export function isErr<T, E>(result: Result<T, E>): result is Err<E> {
	return result.tag === "error";
}
