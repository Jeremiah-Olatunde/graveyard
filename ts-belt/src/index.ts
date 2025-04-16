import { A, B, F, flow, O, pipe } from "@mobily/ts-belt";
import assert from "node:assert";

{
	const ten = O.Some(10);
	assert.equal(true, O.contains(10, ten));
	assert.equal(true, O.contains(10)(ten));
}

{
	const some = O.fromExecution(
		() => "turning and turning in the widening gyre",
	);

	assert(O.isSome(some));

	const none = O.fromExecution(() => {
		throw "error";
	});

	assert(O.isNone(none));
}

{
	const uncertain = () => {
		const boom = Math.random() < 0.5;

		if (boom) {
			throw "BOOM!!";
		}

		return Math.floor(Math.random() * 10);
	};

	const testArray = A.makeWithIndex(10, () => O.fromExecution(uncertain));
}

{
	assert(O.isSome(O.fromNullable(10)));
	assert(O.isSome(O.fromNullable("hello world")));
	assert(O.isSome(O.fromNullable({ name: "jeremiah" })));
	assert(O.isNone(O.fromNullable(null)));
	assert(O.isNone(O.fromNullable(undefined)));
}

{
	const isEven = (n: number) => n % 2 === 0;
	assert(O.isSome(O.fromPredicate(isEven)(10)));
	assert(O.isSome(O.fromPredicate(20, isEven)));
}

{
	const promise = new Promise<number>((resolve) =>
		setTimeout(resolve, 1000, 42),
	);

	const promiseOption = O.fromPromise(promise);
	promiseOption.then(flow(O.isSome, assert));
}
