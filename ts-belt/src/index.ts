import { A, F, O } from "@mobily/ts-belt";
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
