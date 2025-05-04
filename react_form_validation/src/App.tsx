import { useForm, SubmitHandler, SubmitErrorHandler } from "react-hook-form";

type FormData = {
	name: string;
};

export default function App() {
	const { register, handleSubmit, watch } = useForm<FormData>();
	const onSuccess: SubmitHandler<FormData> = (data) => console.log(data);
	const onError: SubmitErrorHandler<FormData> = (errors) =>
		console.error(errors);

	console.log(watch("name"));

	return (
		<>
			<section>
				<header>
					<h1>react hook form</h1>
				</header>

				<form onSubmit={handleSubmit(onSuccess, onError)}>
					<div>
						<label htmlFor="name">name</label>
						<br />
						<input {...register("name", { required: true })} />
					</div>

					<input type="submit" value="submit" />
				</form>
			</section>
		</>
	);
}
