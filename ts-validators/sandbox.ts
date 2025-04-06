type Validator<U> = <T, R extends T & U>(value: T) => value is R;

declare const validateString: Validator<string>;
declare const validateNumber: Validator<number>;
declare const validateBoolean: Validator<boolean>;

declare function composeValidators<Args extends unknown[]>(
	...args: Args
): ExtractValidatorTypes<Args>;

type TestArgs = [Validator<string>, Validator<number>];
type ExtractValidatorTypes<Args> = Args extends Array<Validator<infer T>>
	? T
	: never;

type TestType = ExtractValidatorTypes<TestArgs>;

const test = composeValidators(validateString, validateBoolean);
