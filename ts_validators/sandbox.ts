type Validator<T> = (value: unknown) => value is T;

declare const validateNumber: Validator<number>;
declare const validateBoolean: Validator<boolean>;

declare function composeValidators<Args extends unknown[]>(
	...args: Args
): ExtractValidatorTypes<Args>;

type TestArgs = [Validator<string>, Validator<number>];
type ExtractValidatorTypes<Args> = Args extends Array<Validator<infer T>>
	? T
	: never;

type InspectReturn = ExtractValidatorTypes<TestArgs>;

const test = composeValidators(validateNumber, validateBoolean);
