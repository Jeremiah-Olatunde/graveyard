import { createContext, useContext, useEffect, useReducer } from "react";
import "./App.css";

export default function App() {
	return (
		<ProviderUsers>
			<Core />
		</ProviderUsers>
	);
}

function Core() {
	const { model } = useContextUsers();
	return (
		<section>
			<h1>Context Reducers</h1>
			<UserList model={model} />
		</section>
	);
}

function UserList({ model }: { model: Model }) {
	if (model.status === "loading") {
		return "loading users...";
	}

	if (model.status === "error") {
		return "failed to fetch users";
	}

	return (
		<ul>
			{model.users.map((user) => {
				return (
					<li key={user.id}>
						{user.id}
						<button onClick={() => {}}>delete user</button>
					</li>
				);
			})}
		</ul>
	);
}

type User = {
	id: string;
};

type Model =
	| { status: "ok"; users: User[] }
	| { status: "error"; error: unknown }
	| { status: "loading" };

type Dispatch = (message: Message) => void;

type Message =
	| { type: "fetch loading" }
	| { type: "fetch ok"; users: User[] }
	| { type: "fetch error"; error: unknown };

const ContextUsers = createContext<{
	model: Model;
	dispatch: Dispatch;
} | null>(null);

function useContextUsers() {
	const users = useContext(ContextUsers);
	if (users === null) throw new Error("context value not provided");
	return users;
}

function update(_state: Model, message: Message): Model {
	switch (message.type) {
		case "fetch loading":
			return { status: "loading" };
		case "fetch error":
			return { status: "error", error: message.error };
		case "fetch ok":
			return { status: "ok", users: message.users };
	}
}

function ProviderUsers({ children }: { children: React.ReactNode }) {
	const [model, dispatch] = useReducer(update, { status: "loading" });

	useEffect(() => {
		dispatch({ type: "fetch loading" });
		fetchUsers()
			.then((users) => dispatch({ type: "fetch ok", users }))
			.catch(() => dispatch({ type: "fetch error", error: "500" }));
	}, []);

	return (
		<ContextUsers.Provider value={{ model, dispatch }}>
			{children}
		</ContextUsers.Provider>
	);
}

function generateUser(): User {
	return { id: crypto.randomUUID() };
}

function generateUsers(): User[] {
	const users: User[] = [];
	for (let i = 0; i < 10; i++) users.push(generateUser());
	return users;
}

function fetchUsers(): Promise<User[]> {
	return new Promise((resolve, reject) =>
		setTimeout(Math.random() < 0.5 ? resolve : reject, 1000, generateUsers()),
	);
}
