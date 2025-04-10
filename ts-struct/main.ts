export type Serializable =
	| string
	| number
	| boolean
	| Serializable[]
	| { [index: string]: Serializable };
