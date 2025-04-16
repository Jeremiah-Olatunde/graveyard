import { F, O } from "@mobily/ts-belt";
import assert from "node:assert";

{
	const ten = O.Some(10);
	assert.equal(true, O.contains(10, ten));
	assert.equal(true, O.contains(10)(ten));
}
