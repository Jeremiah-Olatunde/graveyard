import { useForm, SubmitHandler, SubmitErrorHandler } from "react-hook-form";

type FormData = {
	password: string;
};

export default function App() {
	const {
		register,
		handleSubmit,
		formState: { errors },
	} = useForm<FormData>({
		defaultValues: { password: "" },
	});
	const onSuccess: SubmitHandler<FormData> = (data) => console.log(data);
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

						{errors.password && <div>{errors.password.message}</div>}
					</div>

					<input type="submit" value="submit" />
				</form>
			</section>
		</>
	);
}
