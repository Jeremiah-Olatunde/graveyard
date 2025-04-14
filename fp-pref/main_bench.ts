import { filter, fold, map } from "./main.ts";

const testArray: number[] = [];

for (let i = 0; i < 1000; i++) {
	testArray.push(i);
}

Deno.bench({
	name: "map recursive",
	fn: function () {
		map(testArray, (n) => n * n);
	},
});

Deno.bench({
	name: "map built in",
	fn: function () {
		testArray.map((n) => n * n);
	},
});

Deno.bench({
	name: "filter recursive",
	fn: function () {
		filter(testArray, (n) => n % 2 === 0);
	},
});

Deno.bench({
	name: "filter built-in",
	fn: function () {
		testArray.map((n) => n * n);
	},
});

Deno.bench({
	name: "fold recursive",
	fn: function () {
		fold(testArray, 0, (p, n) => p + n);
	},
});

Deno.bench({
	name: "fold built-in",
	fn: function () {
		testArray.reduce((p, n) => p + n, 0);
	},
});
