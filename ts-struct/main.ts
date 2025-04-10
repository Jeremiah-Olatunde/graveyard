export type Serializable =
	| string
	| number
	| boolean
	| Serializable[]
	| { [index: string]: Serializable };

function isSerializable(value: unknown): value is Serializable {
	if (
		typeof value === "string" ||
		typeof value === "number" ||
		typeof value === "boolean"
	) {
		return true;
	}

	if (Array.isArray(value)) {
		return value.every(isSerializable);
	}

	if (typeof value === "object" && value !== null) {
		return Object.values(value).every(isSerializable);
	}

	return false;
}
