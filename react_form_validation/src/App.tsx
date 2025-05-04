import { useForm, SubmitHandler, SubmitErrorHandler } from "react-hook-form";

type FormData = {
	username: string;
	password: string;
};

export default function App() {
	const {
		register,
		handleSubmit,
		formState: { errors },
	} = useForm<FormData>({
		defaultValues: { username: "", password: "" },
	});
	const onSuccess: SubmitHandler<FormData> = (data) => {
		console.log("client side validation successful");
		console.log("submitting");
		login(data)
			.then(console.log)
			.catch((error) =>
				console.error("server side validation failure", error.message),
			);
	};
	const onError: SubmitErrorHandler<FormData> = (errors) =>
		console.error(errors);

	return (
		<>
			<section>
				<header>
					<h1>react hook form</h1>
				</header>

				<form onSubmit={handleSubmit(onSuccess, onError)}>
					<div>
						<label htmlFor="username">username</label>
						<br />
						<input
							{...register("username", {
								required: { value: true, message: "username is required" },
							})}
						/>

						{errors.username && (
							<div style={{ color: "red" }}>{errors.username.message}</div>
						)}
					</div>

					<br />

					<div>
						<label htmlFor="password">password</label>
						<br />
						<input
							{...register("password", {
								required: { value: true, message: "password is required" },
								validate: {
									hasValidLength: (value) => {
										return 8 < value.length || "length must be < 8 characters";
									},
									hasUppercase: (value) => {
										return /[A-Z]/.test(value) || "must have a capital letter";
									},
									hasLowercase: (value) => {
										return /[a-z]/.test(value) || "must have a capital letter";
									},
									hasSymbol: (value) => {
										return /[@#$%^&*!()]/.test(value) || "must have a symbol";
									},
									hasDigit: (value) => {
										return /[0-9]/.test(value) || "must contain digit";
									},
								},
							})}
						/>

						{errors.password && (
							<div style={{ color: "red" }}>{errors.password.message}</div>
						)}
					</div>

					<br />

					<input type="submit" value="submit" />
				</form>
			</section>
		</>
	);
}

type DetailsLogin = Readonly<{
	username: string;
	password: string;
}>;

function sleep(time: number): Promise<void> {
	return new Promise((resolve) => {
		setTimeout(resolve, time);
	});
}

async function login(details: DetailsLogin): Promise<string> {
	await sleep(2000);
	const password = DB[details.username];
	if (password === undefined) {
		throw new Error("username not found");
	}

	if (password !== details.password) {
		throw new Error("invalid password not found");
	}

	return "jwt-token";
}

const DB: Record<string, string> = {
	roman: "goodbyeWORLD123#@!",
	jeremiah: "helloWORLD123#@!",
};
