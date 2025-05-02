export function commaDelimitedAmt(val: string): string {
	const [whole, fractional = ""] = val.split(".");
	const comma = fn(whole).join(",");
	return `${comma}.${fractional.padEnd(2, "0")}`;
}

function group(xs: string, count: number): string[] {
	if (xs === "") return [];
	const [batched, tail] = splitN(xs, count);
	return [batched, ...group(tail, count)];
}

function groupIterative(xs: string, count: number): string[] {
	const grouped: string[] = [];

	for (let i = 0; i < xs.length; i += 3) {
		grouped.push(xs.slice(i, i + 3));
	}

	return grouped;
}

function splitN(xs: string, count: number): [string, string] {
	return [xs.slice(0, count), xs.slice(count)];
}

function fn(xs: string): string[] {
	const mod = xs.length % 3;
	if (mod === 0) return groupIterative(xs, 3);

	const [first, tail] = splitN(xs, mod);
	return [first, ...groupIterative(tail, 3)];
}

function random(): string {
	return Math.floor(Math.random() * 1_000_000).toString();
}

console.log(commaDelimitedAmt(random()));
console.log(commaDelimitedAmt(random()));
console.log(commaDelimitedAmt(random()));
console.log(commaDelimitedAmt(random()));
console.log(commaDelimitedAmt(random()));
console.log(commaDelimitedAmt(random()));
console.log(commaDelimitedAmt(random()));

console.log("hello world".slice(0, 3));
