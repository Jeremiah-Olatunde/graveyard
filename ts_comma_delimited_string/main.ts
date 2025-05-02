export function take(xs: string, count: number): string {
	return xs.slice(0, count);
}

export function drop(xs: string, count: number): string {
	return xs.slice(count);
}

export function group(xs: string, count: number): string[] {
	if (xs === "") return [];
	const head = take(xs, count);
	const tail = drop(xs, count);
	return [head, ...group(tail, count)];
}

function group3(xs: string): string[] {
	const mod = xs.length % 3;
	const head = take(xs, mod);
	const tail = drop(xs, mod);
	return [head, ...group(tail, 3)];
}

export function commaDelimitedAmount(amount: string): string {
	const [whole, fractional = ""] = amount.split(".");
	const formattedWhole = group3(whole);
	return `${formattedWhole}.${fractional.padEnd(2, "0")}`;
}
