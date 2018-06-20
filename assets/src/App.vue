<template>
  <div id="app">
    <navbar-menu v-if="loggedInUser" :user="currentUser" @logout="logout"/>
    <ideas-list-view v-if="loggedInUser" :ideas="ideas" :user="currentUser"/>
    <login-view v-else @login="loginUser"/>
  </div>
</template>

<script>
import NavbarMenu from "@/components/shared/NavbarMenu";
import IdeasListView from "@/views/IdeasListView";
import LoginView from "@/views/LoginView";

const ideas = [
  {
    id: 0,
    title: "Projeto Ideação",
    problem:
      "Colaboração de equipes no processo de validação de ideias e inovação",
    description:
      "Plataforma online para facilitar a colaboração de equipes no projeto",
    feedbacks: [
      {
        id: 1,
        rating: 8.5,
        comment: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi beatae minus iusto repudiandae recusandae, ullam, officiis odit totam expedita quas facere rerum alias accusantium natus!",
        user: { name: "Maxsuel", id: 1 }
      },
      {
        id: 2,
        rating: 6,
        comment: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi beatae minus iusto repudiandae recusandae, ullam, officiis odit totam expedita quas facere rerum alias accusantium natus!",
        user: { name: "Mateus", id: 2 }
      }
    ],
    author: {
      id: 1,
      name: "Maxsuel Maccari"
    }
  },
  {
    id: 1,
    title: "Projeto MyShopping",
    problem:
      "Lista de compras em supermercado em tempo real para casais e famílias",
    description:
      "Um aplicativo que fornece as funcionalidades necessárias para a lista",
    feedbacks: [],
    author: {
      id: 1,
      name: "Maxsuel Maccari"
    }
  },
  {
    id: 2,
    title: "Alugga",
    problem: "Gestão de imóveis",
    description: "Plataforma online para facilitar a gestão de imóveis",
    feedbacks: [
      {
        id: 3,
        rating: 9.5,
        comment: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi beatae minus iusto repudiandae recusandae, ullam, officiis odit totam expedita quas facere rerum alias accusantium natus!",
        user: { name: "Mateus", id: 2 }
      }
    ],
    author: {
      id: 1,
      name: "Maxsuel Maccari"
    }
  },
  {
    id: 3,
    title: "AcompanheAki",
    problem: "Falta de acompanhamento dos pais na vida escolar dos filhos",
    description:
      "Plataforma online para fomentar o acompanhamento dos pais na vida dos alunos",
    feedbacks: [],
    author: {
      id: 3,
      name: "Maurício Maccari"
    }
  }
];

export default {
  name: "app",
  components: {
    IdeasListView,
    LoginView,
    NavbarMenu
  },
  data() {
    return {
      ideas: ideas,
      currentUser: null
    };
  },
  computed: {
    loggedInUser() {
      return !!this.currentUser;
    }
  },
  methods: {
    loginUser(user) {
      this.currentUser = user;
    },
    logout() {
      this.currentUser = null;
    }
  }
};
</script>

<style>
</style>
