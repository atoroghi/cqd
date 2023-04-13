#!/bin/bash
#SBATCH --job-name=zero
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --exclusive
#SBATCH --time=00:08:00
#SBATCH --account=def-ssanner
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

#wandb offline
#wandb online -num_run 
#wandb agent atoroghi/pre-critiquing/xydr8uhv
#python3 launch.py -epochs 1 -save_each 1 -kg no_kg
source ~/projects/def-ssanner/atoroghi/project/ENV/bin/activate
cd ~/projects/def-ssanner/atoroghi/project/cqd
#python3 nested_cv_zero.py -tune_name soft_best -reg_type gauss -loss_type softplus -reduce_type sum -optim_type adagrad -sample_type split_rev -init_type uniform -kg kg 
#python3 nested_cv_zero.py -tune_name svd_neg_soft -reg_type gauss -loss_type softplus -reduce_type sum -optim_type adagrad -sample_type split_reg -init_type uniform -learning_rel freeze -kg no_kg 
#python3 inner_cv.py -tune_name gaussindirect -fold 0
#for dataset in FB15k-237; do
#	for t_norm in min; do
#		for candidate in 4 8 16; do
#			sbatch --export=DATA=${dataset},T_NORM=${t_norm},CANDIDATE=${candidate} NewPA_job.sh
#		done
#	done
#done
for dataset in FB15k-237; do
	for chain_type in 1_3; do
		for cov_anchor in 1e-2 1e-3 1e-4 1e-5;do
			for cov_var in 1e-5 1e-4 1e-3 1e-2 1e-1 1e1 1e2 1e3 1e4 1e5; do
				for cov_target in 1e-5 1e-4 1e-3 1e-2 1e-1 1e1 1e2 1e3 1e4 1e5; do
					sbatch --export=DATASET=${dataset},CHAIN_TYPE=${chain_type},COV_ANCHOR=${cov_anchor},COV_VAR=${cov_var},COV_TARGET=${cov_target} co_NewPA_job.sh
				done
			done
		done
	done
done
