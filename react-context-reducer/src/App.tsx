import { createContext, useContext, useState } from "react";
import "./App.css";

export default function App() {
	return (
		<ProviderUsers>
			<Core />
		</ProviderUsers>
	);
}

function Core() {
	const { users, addUser, deleteUser } = useContextUsers();
	return (
		<section>
			<h1>Context Reducers</h1>
			<ul>
				{users.map((user) => {
					return (
						<li key={user.id}>
							{user.id}
							<button onClick={() => deleteUser(user)}>delete user</button>
						</li>
					);
				})}
			</ul>
			<button onClick={() => addUser(generateUser())}>add user</button>
		</section>
	);
}

type User = {
	id: string;
};

type StoreUsers = {
	users: User[];
	addUser: (user: User) => void;
	deleteUser: (user: User) => void;
};

const ContextUsers = createContext<StoreUsers | null>(null);

function useContextUsers() {
	const users = useContext(ContextUsers);
	if (users === null) throw new Error("context value not provided");
	return users;
}

function ProviderUsers({ children }: { children: React.ReactNode }) {
	const [users, setUsers] = useState(generateUsers());

	function addUser(user: User) {
		setUsers([...users, user]);
	}

	function deleteUser({ id }: User) {
		setUsers(users.filter((user) => user.id !== id));
	}

	return (
		<ContextUsers.Provider value={{ users, addUser, deleteUser }}>
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
